import 'package:meta/meta.dart';

/// Suggested demo prompts for one patient; anything else can be typed.
@immutable
class DemoScenario {
  /// The check-in complaint that leads to the hidden emergency.
  final String checkInText;

  /// A second complaint, answered by another part of the same chart.
  final String alternativeComplaint;

  /// A finding to add during the exam.
  final String findingText;

  /// Creates a scenario.
  const DemoScenario({
    required this.checkInText,
    required this.alternativeComplaint,
    required this.findingText,
  });
}
