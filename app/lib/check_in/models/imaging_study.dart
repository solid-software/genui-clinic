import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// A radiology study on file.
@immutable
class ImagingStudy {
  /// Modality and region, e.g. `Chest X-ray`.
  final String modality;

  /// When it was performed.
  final DateTime takenAt;

  /// The reported conclusion, e.g. `No focal changes`.
  final String conclusion;

  /// Asset path of the image, when one is on file.
  final String? image;

  /// Creates an imaging study.
  const ImagingStudy({
    required this.modality,
    required this.takenAt,
    required this.conclusion,
    this.image,
  });

  /// Reads a study from its stored form.
  factory ImagingStudy.fromJson(Map<String, Object?> json) => ImagingStudy(
    modality: json.readString('modality'),
    takenAt: json.readDate('takenAt'),
    conclusion: json.readString('conclusion'),
    image: json.readOptionalString('image'),
  );

  /// The stored form of this study.
  Map<String, Object?> toJson() => <String, Object?>{
    'modality': modality,
    'takenAt': takenAt.toIso8601String(),
    'conclusion': conclusion,
    if (image != null) 'image': image,
  };
}
