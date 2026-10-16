import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One study on an imaging timeline.
@immutable
class ImagingEvent {
  /// What was done, e.g. `Chest X-ray`.
  final String modality;

  /// When, as written, e.g. `Nov 2021`.
  final String date;

  /// What it showed, in the words of the report.
  final String conclusion;

  /// How much attention the study should draw.
  final ClinicalTone tone;

  /// Asset path of the study's image, when the record has one.
  final String? image;

  /// Creates an imaging event.
  const ImagingEvent({
    required this.modality,
    required this.date,
    required this.conclusion,
    this.image,
    this.tone = ClinicalTone.neutral,
  });

  /// Reads an event from an A2UI component payload.
  factory ImagingEvent.fromJson(Map<String, Object?> json) => ImagingEvent(
    modality: json.readString('modality'),
    date: json.readString('date'),
    conclusion: json.readString('conclusion'),
    image: json.readOptionalString('image'),
    tone: ClinicalTone.fromWire(json['tone']),
  );
}
