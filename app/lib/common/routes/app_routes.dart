/// The paths the app's screens open at.
abstract final class AppRoutes {
  /// Today's list, at the front desk; where the app starts.
  static const String checkIn = '/check_in';

  /// One visit's brief; a `DashboardLink` carries its parameters.
  static const String dashboard = '/dashboard';

  /// Every component a brief can be built from, drawn live.
  static const String catalog = '/catalog';
}
