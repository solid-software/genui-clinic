import 'dart:async';

import 'package:clinical_brief/brief_composer/brief_composer.dart';
import 'package:clinical_brief/brief_composer/brief_limit_exception.dart';
import 'package:clinical_brief/brief_composer/models/brief_limit.dart';
import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/repository/patient_repository.dart';
import 'package:clinical_brief/common/logging/app_logger.dart';
import 'package:clinical_brief/medical_catalog/surface_readiness.dart';
import 'package:flutter/foundation.dart';
import 'package:genui/genui.dart';
import 'package:logging/logging.dart';

/// Drives one consultation: the chart, the brief and the surface on screen.
class DashboardController extends ChangeNotifier {
  static const String _failureMessage =
      'The brief could not be composed. The AI service may be busy or sent '
      'something that cannot be displayed. The record is unchanged; '
      'try again in a moment.';

  /// The patient being seen.
  final Patient patient;

  final PatientRepository _repository;
  final List<String> _surfaceIds = <String>[];
  final Logger _log = AppLogger.of('DashboardController');
  final BriefComposer _composer;

  Complaint _complaint;
  ClinicalRecord? _record;
  StreamSubscription<ConversationEvent>? _events;
  Future<void> Function()? _lastRequest;
  String? _errorMessage;
  bool _isComposing = true;
  bool _isDisposed = false;
  BriefLimit? _limit;
  DateTime? _retryAt;
  Timer? _cooldown;

  /// The complaint as it stands, including anything added during the exam.
  Complaint get complaint => _complaint;

  /// The chart, or `null` until it is loaded.
  ClinicalRecord? get record => _record;

  /// Where the dashboard reads surfaces from.
  SurfaceHost get surfaceHost => _composer.surfaceHost;

  /// The newest surface that can draw, or `null` before the first one.
  ///
  /// Needs a root component, so the old brief stays until the new one draws.
  String? get activeSurfaceId => _surfaceIds.isEmpty ? null : _surfaceIds.last;

  /// Why composition failed, or `null`.
  String? get errorMessage => _errorMessage;

  /// Whether the model is still writing.
  bool get isComposing => _isComposing;

  /// When a request the agent refused for a limit may be sent again, or
  /// `null` when nothing is waiting.
  DateTime? get retryAt => _isOutOfBriefs ? null : _retryAt;

  /// Whether the daily limit is used up.
  bool get _isOutOfBriefs => _limit == .daily;

  /// Whether the last request failed and can be sent again now.
  bool get canRetry =>
      _errorMessage != null &&
      _lastRequest != null &&
      !_isComposing &&
      _retryAt == null &&
      !_isOutOfBriefs;

  /// Creates a controller for one visit.
  DashboardController({
    required this._composer,
    required this._repository,
    required this.patient,
    required Complaint initialComplaint,
  }) : _complaint = initialComplaint;

  /// Loads the chart and asks for the opening brief.
  Future<void> start() async {
    _events = _composer.events.listen(_onConversationEvent);
    await _run(_composeOpening);
  }

  /// Adds an exam finding and re-ranks the brief around the whole complaint.
  Future<void> addFinding(String finding) async {
    if (finding.trim().isEmpty) {
      return;
    }

    _complaint = _complaint.withAddendum(finding.trim());
    await _run(_composeAmendment);
  }

  /// Sends the request that last failed again.
  ///
  /// The complaint is read at send time, so a retry has every finding.
  Future<void> retry() async {
    final Future<void> Function()? request = _lastRequest;
    if (request == null || !canRetry) {
      return;
    }

    await _run(request);
  }

  @override
  void notifyListeners() {
    // A request can outlive the screen; never notify once disposed.
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _cooldown?.cancel();
    unawaited(_events?.cancel());
    _composer.dispose();
    super.dispose();
  }

  Future<void> _composeOpening() async {
    final ClinicalRecord record = await _repository.fetchRecord(patient.id);
    _record = record;
    notifyListeners();
    await _composer.compose(
      patient: patient,
      record: record,
      complaint: _complaint,
    );
  }

  /// Without a chart there was no brief to amend: open with the whole
  /// complaint instead.
  Future<void> _composeAmendment() =>
      _record == null ? _composeOpening() : _composer.amend(_complaint);

  Future<void> _run(Future<void> Function() body) async {
    _lastRequest = body;
    _isComposing = true;
    _errorMessage = null;
    _clearLimit();
    notifyListeners();
    try {
      await body();
    } on BriefLimitException catch (exception) {
      _errorMessage = exception.message;
      _limit = exception.limit;
      if (!_isOutOfBriefs) {
        _coolDown(exception.retryAfter);
      }
    } on Exception catch (exception, stackTrace) {
      _log.severe('Could not compose the brief', exception, stackTrace);
      _errorMessage = _failureMessage;
    } finally {
      _isComposing = false;
      notifyListeners();
    }
  }

  /// Holds retries back for [wait], then lets them through again.
  void _coolDown(Duration wait) {
    _retryAt = DateTime.now().add(wait);
    _cooldown = Timer(wait, () {
      _retryAt = null;
      notifyListeners();
    });
  }

  void _clearLimit() {
    _cooldown?.cancel();
    _cooldown = null;
    _retryAt = null;
    _limit = null;
  }

  void _showWhenRenderable(String surfaceId, SurfaceDefinition definition) {
    if (!definition.isRenderable || _surfaceIds.contains(surfaceId)) {
      return;
    }

    _surfaceIds.add(surfaceId);
    notifyListeners();
  }

  void _onConversationEvent(ConversationEvent event) {
    switch (event) {
      case ConversationSurfaceAdded(
        :final String surfaceId,
        :final SurfaceDefinition definition,
      ):
        _showWhenRenderable(surfaceId, definition);
      case ConversationComponentsUpdated(
        :final String surfaceId,
        :final SurfaceDefinition definition,
      ):
        _showWhenRenderable(surfaceId, definition);
      case ConversationSurfaceRemoved(:final String surfaceId):
        _surfaceIds.remove(surfaceId);
        notifyListeners();
      case ConversationError(:final Object error):
        _log.severe('Model reported an error', error);
        _errorMessage = _failureMessage;
        notifyListeners();
      case ConversationContentReceived():
      case ConversationWaiting():
        break;
    }
  }
}
