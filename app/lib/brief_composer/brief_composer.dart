import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:clinical_brief/brief_composer/conversation_event.dart';
import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';

/// Composes one consultation's brief; refinements are follow-up turns.
abstract interface class BriefComposer {
  /// The processor the dashboard screen renders surfaces from.
  MessageProcessor<ComponentImplementation> get surfaceHost;

  /// Surface lifecycle, text and error events from the conversation.
  Stream<ConversationEvent> get events;

  /// Asks for the first brief.
  Future<void> compose({
    required Patient patient,
    required ClinicalRecord record,
    required Complaint complaint,
  });

  /// Asks for a new brief around an enlarged [complaint].
  Future<void> amend(Complaint complaint);

  /// Releases the underlying transport and controller.
  void dispose();
}
