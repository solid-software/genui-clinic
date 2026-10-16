import 'package:meta/meta.dart';

/// Why the patient came, growing as the doctor adds findings.
@immutable
class Complaint {
  /// What was written at check-in, including any duration or vitals.
  final String presentingText;

  /// Findings added during the visit, in order.
  final List<String> addenda;

  /// Creates a complaint.
  const Complaint({
    required this.presentingText,
    this.addenda = const <String>[],
  });

  /// A copy with [addendum] added.
  Complaint withAddendum(String addendum) => Complaint(
    presentingText: presentingText,
    addenda: <String>[...addenda, addendum],
  );

  /// The form the brief agent reads.
  Map<String, Object?> toJson() => {
    'presentingText': presentingText,
    'addedDuringExam': addenda,
  };
}
