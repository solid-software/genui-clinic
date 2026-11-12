import 'dart:async';

import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:clinical_brief/brief_composer/brief_composer.dart';
import 'package:clinical_brief/brief_composer/brief_transport.dart';
import 'package:clinical_brief/brief_composer/conversation_event.dart';
import 'package:clinical_brief/brief_composer/models/brief_turn.dart';
import 'package:clinical_brief/brief_composer/services/brief_agent_client.dart';
import 'package:clinical_brief/brief_composer/unrenderable_brief_exception.dart';
import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/common/logging/app_logger.dart';
import 'package:clinical_brief/medical_catalog/medical_catalog.dart';
import 'package:clinical_brief/medical_catalog/surface_readiness.dart';

/// [BriefComposer] built on the A2UI runtime, with the brief agent writing
/// the briefs.
class GenUiBriefComposer._(
  /// The processor that owns the surfaces this composer produces.
  @override final MessageProcessor<ComponentImplementation> surfaceHost,
  final BriefTransport _transport,
  final StreamController<ConversationEvent> _events,
  final List<Subscription> _subscriptions,
) implements BriefComposer {
  /// The wire version every surface this composer creates is rendered as.
  static final String _version = A2uiProtocolVersion.v1_0.jsonValue;

  final _log = AppLogger.of('GenUiBriefComposer');
  final _readySurfaceIds = <String>{};
  var _inFlight = Future<void>.value();
  var _isDisposed = false;
  ({Patient patient, ClinicalRecord record})? _consultation;

  @override
  Stream<ConversationEvent> get events => _events.stream;

  /// Starts a composer for one consultation, asking [agent] for each brief.
  ///
  /// Every request names the catalog this app renders, which the agent
  /// registered from the same definition (see test/agent_catalog_test.dart).
  factory GenUiBriefComposer.start(BriefAgentClient agent) {
    final processor = MessageProcessor<ComponentImplementation>(
      catalogs: [MedicalCatalog.build()],
      validationConfig: ValidationConfig.relaxed,
      reportErrorsOnly: true,
    );
    final capabilities = processor
        .getRendererCapabilities(
          const CapabilitiesOptions(versions: [A2uiProtocolVersion.v1_0]),
        )
        .toJson();
    final events = StreamController<ConversationEvent>.broadcast();
    final composer = GenUiBriefComposer._(
      processor,
      BriefTransport(agent, capabilities, processor.processMessages),
      events,
      [],
    );
    composer._subscriptions.addAll([
      processor.model.onAction.subscribe(composer._sendAction),
      processor.model.onError.subscribe(composer._onError),
      processor.model.onSurfaceDeleted.subscribe(composer._onSurfaceDeleted),
    ]);

    return composer;
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
    _inFlight.whenComplete(_disposeSurfaces).ignore();
  }

  /// Sends [turn] and throws if the brief that comes back cannot be drawn.
  ///
  /// The agent already asks the model again for a brief it cannot compile.
  Future<void> _requestBrief(BriefTurn turn) async {
    if (_isDisposed) return;
    _inFlight = _transport.send(turn);
    await _inFlight;
    if (_isDisposed) return;
    if (!_reportReadySurfaces()) {
      throw const UnrenderableBriefException();
    }
  }

  void _disposeSurfaces() {
    for (final subscription in _subscriptions) {
      subscription.unsubscribe();
    }
    surfaceHost.dispose();
    unawaited(_events.close());
  }

  void _sendAction(A2uiRendererAction action) {
    unawaited(
      _transport.send(
        BriefTurn.rendererEvent(
          ActionMessage(version: _version, action: action).toJson(),
        ),
      ),
    );
  }

  /// Logs an error found while rendering a brief.
  ///
  /// The agent already checked the brief against the catalog before sending
  /// it, so asking it again here could loop; only [events] hears about it.
  void _onError(A2uiRendererError error) {
    _log.warning(
      'The brief surface reported a problem: ${error.code} ${error.message}',
    );
    if (!_isDisposed) {
      _events.add(ConversationError(error));
    }
  }

  void _onSurfaceDeleted(String surfaceId) {
    _readySurfaceIds.remove(surfaceId);
    if (!_isDisposed) {
      _events.add(ConversationSurfaceRemoved(surfaceId));
    }
  }

  /// Reports every surface that became renderable since the brief before,
  /// and whether any surface can be drawn now.
  ///
  /// A whole brief is applied to [surfaceHost] in one synchronous batch (see
  /// [BriefTransport]), so every surface it creates already has its root by
  /// the time its turn's [Future] completes; nothing replaces the
  /// "components updated" event a streamed reply would need.
  bool _reportReadySurfaces() {
    var isDrawn = false;
    for (final surface in surfaceHost.model.allSurfaces) {
      if (!surface.isRenderable) continue;
      isDrawn = true;
      if (_readySurfaceIds.add(surface.id) && !_isDisposed) {
        _events.add(ConversationSurfaceReady(surface.id));
      }
    }

    return isDrawn;
  }
}
