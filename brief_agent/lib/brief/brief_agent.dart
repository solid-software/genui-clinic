import 'dart:async';

import 'package:a2ui_agent/a2ui_agent.dart';
import 'package:a2ui_core/a2ui_core.dart';
import 'package:brief_agent/brief/brief_prompt.dart';
import 'package:brief_agent/brief/brief_rejected_exception.dart';
import 'package:brief_agent/brief/brief_rules.dart';
import 'package:brief_agent/brief/express_cleanup.dart';
import 'package:brief_agent/brief/models/brief_request.dart';
import 'package:brief_agent/catalog/clinical_catalog.dart';
import 'package:brief_agent/gemini/gemini_client.dart';
import 'package:brief_agent/gemini/models/gemini_content.dart';
import 'package:firebase_functions/logger.dart' as logger;

/// Composes briefs with the A2UI agent SDK: Gemini writes A2UI Express, the
/// SDK parses it into A2UI messages, and the app receives their JSON.
///
/// Express never leaves the agent. The app sends the consultation back as
/// A2UI JSON with every turn, and the SDK writes its briefs as Express again
/// for the model's history.
class BriefAgent(final GeminiClient _gemini) {
  /// The longest a brief may take, retries and repair included, inside the
  /// function's 300 s.
  static const budget = Duration(seconds: 240);

  /// Resend requests for a reply that is not a brief before giving up.
  static const _maxRepairs = 1;

  /// The SDK's entry point, with every catalog this agent supports.
  final _generator = A2uiGenerator(
    catalogs: [ClinicalCatalog.config()],
    inferenceFormatFactory: const ExpressFormatFactory(
      allowedMessages: BriefRules.messageTypes,
    ),
  );

  /// Creates an agent that asks [_gemini] for each brief.
  ///
  /// Throws [StateError] while the catalog document is a placeholder.
  this;

  /// The A2UI JSON messages of a new brief that answers [request].
  ///
  /// Throws [A2uiError] if the app renders none of this agent's catalogs or
  /// sends a brief this agent could not have sent, [BriefRejectedException]
  /// if the model's reply is not a brief even after a repair turn,
  /// [TimeoutException] past the [budget], and what [GeminiClient.reply]
  /// throws.
  Future<List<Map<String, Object?>>> compose(BriefRequest request) async {
    final clock = Stopwatch()..start();
    final processor = _generator.createProcessor(
      A2uiRendererCapabilities.fromJson(request.capabilities),
    );
    final parser = processor.formatFactory
        .createFormat(processor.activeCatalogs)
        .createParser();
    final system = BriefPrompt.system(
      formatPrompt: processor.promptSnippet,
      today: request.opening.today,
    );
    final contents = <GeminiContent>[
      for (final exchange in request.history) ...[
        .user(BriefPrompt.turn(exchange.turn)),
        .model(_expressOf(parser, exchange.brief)),
      ],
      .user(BriefPrompt.turn(request.turn)),
    ];
    for (var repair = 0; ; repair++) {
      _checkBudget(clock);
      final reply = await _gemini.reply(
        systemInstruction: system,
        contents: contents,
      );
      try {
        return _briefIn(
          processor,
          parser,
          reply,
        ).map((m) => m.toJson()).toList();
      } on BriefRejectedException catch (error) {
        if (repair >= _maxRepairs) rethrow;

        logger.warning(
          'The reply is not a brief; asking the model to resend.',
          {'problem': error.message, 'reply': reply},
        );
        contents
          ..add(.model(reply))
          ..add(.user(BriefPrompt.repair(error.message)));
      }
    }
  }

  /// [brief], A2UI JSON this agent sent earlier, written as the Express
  /// reply it was compiled from: what the model sees of its earlier briefs.
  ///
  /// Throws [A2uiError] if [brief] is not one this agent could have sent.
  static String _expressOf(Parser parser, List<Map<String, Object?>> brief) =>
      parser.wrap([
        RawA2uiPart(
          parser.decompile(brief.map(AgentToRendererMessage.fromJson).toList()),
        ),
      ]);

  /// Throws [TimeoutException] once [clock] has run past the [budget].
  static void _checkBudget(Stopwatch clock) {
    if (clock.elapsed > budget) {
      throw TimeoutException('The brief took longer than $budget.', budget);
    }
  }

  /// The brief in [reply], as [processor] parses and checks it once the
  /// slips Gemini makes in Express are cleaned up (see [ExpressCleanup]).
  ///
  /// Throws [BriefRejectedException], with a reason the model can act on, if
  /// the reply is not exactly one valid brief.
  static List<AgentToRendererMessage> _briefIn(
    A2uiRequestProcessor processor,
    Parser parser,
    String reply,
  ) {
    final (reply: cleaned, :fixes) = ExpressCleanup.cleanReply(parser, reply);
    if (fixes > 0) {
      logger.info(
        'Cleaned up $fixes slips (a misplaced : or =, or a null '
        'map entry) before compiling.',
      );
    }

    final List<ResponsePart> parts;
    try {
      parts = processor.parseResponse(cleaned);
    } on A2uiError catch (error) {
      throw BriefRejectedException(message: error.message);
    } on FormatException {
      // int.parse of a literal too large for an int.
      throw const BriefRejectedException(
        message: 'A number in the block is too large; write it as a string.',
      );
    }
    return BriefRules.briefIn(
      parts,
      surfaceId: 'brief-${DateTime.now().microsecondsSinceEpoch}',
    );
  }
}
