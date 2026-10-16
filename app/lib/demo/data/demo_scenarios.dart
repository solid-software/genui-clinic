import 'package:clinical_brief/demo/data/patients/john_miller.dart';
import 'package:clinical_brief/demo/data/patients/margaret_collins.dart';
import 'package:clinical_brief/demo/data/patients/patricia_evans.dart';
import 'package:clinical_brief/demo/models/demo_scenario.dart';

/// The demo prompts, by patient id.
abstract final class DemoScenarios {
  static const Map<String, DemoScenario> _byPatientId = {
    JohnMiller.id: DemoScenario(
      checkInText:
          'cough, gets winded on the stairs, 3 weeks. '
          'BP 146/88, SpO2 95%, no fever',
      alternativeComplaint:
          'routine diabetes and blood pressure review, feels well, no new '
          'symptoms',
      findingText:
          'breathing got worse during the exam, right calf sore and swollen '
          'for about a week. SpO2 now 89%, HR 108',
    ),
    MargaretCollins.id: DemoScenario(
      checkInText:
          'very tired, dizzy when standing up, about 1 week. '
          'BP 104/62, pulse 102',
      alternativeComplaint:
          'medication review before a knee replacement next month',
      findingText:
          'nearly fainted at the sink this morning, looks very pale. Lying BP '
          '112/68, standing BP 92/58, pulse 110 standing',
    ),
    PatriciaEvans.id: DemoScenario(
      checkInText:
          'burning in the upper stomach on and off for 2 weeks, more tired '
          'than usual, omeprazole not helping. BP 158/94, pulse 88',
      alternativeComplaint:
          'annual diabetes check, wants to talk about her eyes',
      findingText:
          'the burning comes on when climbing stairs and eases with rest. '
          'This morning 20 minutes of the same pressure spreading to the '
          'left jaw, with sweating. HR 96, BP 162/96',
    ),
  };

  /// The prompts for [patientId], or `null` for a patient without any.
  static DemoScenario? forPatient(String patientId) => _byPatientId[patientId];
}
