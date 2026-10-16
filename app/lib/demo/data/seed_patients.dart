import 'package:clinical_brief/demo/data/patients/john_miller.dart';
import 'package:clinical_brief/demo/data/patients/margaret_collins.dart';
import 'package:clinical_brief/demo/data/patients/patricia_evans.dart';

/// Demo patients stored on first launch, as `{id, patient, record}` maps.
///
/// Kept in stored form so the entity factories stay the only reader.
abstract final class SeedPatients {
  /// Every demo patient, in the order they are stored.
  static const List<Map<String, Object?>> all = [
    JohnMiller.seed,
    MargaretCollins.seed,
    PatriciaEvans.seed,
  ];
}
