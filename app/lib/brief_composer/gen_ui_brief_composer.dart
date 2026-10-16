import 'dart:async';

import 'package:clinical_brief/brief_composer/brief_composer.dart';
import 'package:clinical_brief/brief_composer/brief_transport.dart';
import 'package:clinical_brief/brief_composer/models/brief_turn.dart';
import 'package:clinical_brief/brief_composer/services/brief_agent_client.dart';
import 'package:clinical_brief/brief_composer/unrenderable_brief_exception.dart';
import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/medical_catalog/medical_catalog.dart';
import 'package:clinical_brief/medical_catalog/surface_readiness.dart';
import 'package:genui/genui.dart';

/// [BriefComposer] built on the GenUI runtime, with the brief agent writing
/// the briefs.
class GenUiBriefComposer._(
  final Conversation _conversation,
  final BriefTransport _transport,

  /// The controller that owns the surfaces this composer produces.
  @override final SurfaceController surfaceHost,
) implements BriefComposer {
  var _inFlight = Future<void>.value();
  var _isDisposed = false;
  ({Patient patient, ClinicalRecord record})? _consultation;

  @override
  Stream<ConversationEvent> get events => _conversation.events;

  /// Starts a composer for one consultation, asking [agent] for each brief.
  ///
  /// Every request names the catalog this app renders, which the agent
  /// registered from the same definition (see test/agent_catalog_test.dart).
  factory GenUiBriefComposer.start(BriefAgentClient agent) {
    final controller = SurfaceController(catalogs: [MedicalCatalog.build()]);
    final transport = BriefTransport(
      agent,
      controller.clientCapabilities.toJson(),
    );

    return GenUiBriefComposer._(
      Conversation(controller: controller, transport: transport),
      transport,
      controller,
    );
  }

  @override
  Future<void> compose({
    required Patient patient,
    required ClinicalRecord record,
    required Complaint complaint,
  }) {
    _consultation = (patient: patient, record: record);

    return _requestBrief(
      BriefTurn.opening(patient: patient, record: record, complaint: complaint),
    );
  }

  /// Asks for a new brief around [complaint]; with no brief to amend, as
  /// after a failed opening, starts again with the whole complaint.
  @override
  Future<void> amend(Complaint complaint) {
    final consultation = _consultation;

    return _requestBrief(
      _transport.hasBrief || consultation == null
          ? .amendment(complaint)
          : .opening(
              patient: consultation.patient,
              record: consultation.record,
              complaint: complaint,
            ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _transport.dispose();
    // Released once the turn in flight ends; the closed transport drops its
    // brief.
    _inFlight.whenComplete(_disposeConversation).ignore();
  }

  /// Sends [turn] and throws if the brief that comes back cannot be drawn.
  ///
  /// The agent already asks the model again for a brief it cannot compile.
  Future<void> _requestBrief(BriefTurn turn) async {
    if (_isDisposed) return;
    var isDrawn = false;
    final subscription = _conversation.events.listen(
      (event) => isDrawn |= _drawsBrief(event),
    );
    try {
      _inFlight = _transport.send(turn);
      await _inFlight;
      // Let the messages reach the controller before reading the outcome.
      await Future<void>.delayed(Duration.zero);
    } finally {
      await subscription.cancel();
    }
    if (!isDrawn && !_isDisposed) {
      throw const UnrenderableBriefException();
    }
  }

  void _disposeConversation() {
    _conversation.dispose();
    surfaceHost.dispose();
  }

  /// Whether [event] brings a surface with a root component.
  static bool _drawsBrief(ConversationEvent event) => switch (event) {
    ConversationSurfaceAdded(:final definition) ||
    ConversationComponentsUpdated(:final definition) => definition.isRenderable,
    _ => false,
  };
}
