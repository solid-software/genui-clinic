import 'package:clinical_brief/common/routes/app_routes.dart';
import 'package:meta/meta.dart';

/// A link to one visit's brief:
/// `/dashboard?patientId=<id>&complaint=<text>`.
@immutable
class DashboardLink {
  static const _patientIdParameter = 'patientId';
  static const _complaintParameter = 'complaint';

  /// The patient being seen.
  final String patientId;

  /// The complaint written at check-in.
  final String complaint;

  /// Whether both parameters are there; an incomplete link opens nothing.
  bool get isComplete => patientId.isNotEmpty && complaint.isNotEmpty;

  /// Where the link points, query included.
  String get location => Uri(
    path: AppRoutes.dashboard,
    queryParameters: {
      _patientIdParameter: patientId,
      _complaintParameter: complaint,
    },
  ).toString();

  /// Creates a link to the brief for [patientId], composed around [complaint].
  const DashboardLink({required this.patientId, required this.complaint});

  /// Reads the parameters of [uri]; a missing one is empty.
  factory DashboardLink.fromUri(Uri uri) => DashboardLink(
    patientId: uri.queryParameters[_patientIdParameter]?.trim() ?? '',
    complaint: uri.queryParameters[_complaintParameter]?.trim() ?? '',
  );
}
