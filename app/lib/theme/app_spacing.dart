/// The spacing scale and sizes shared by native and generated UI.
abstract final class AppSpacing {
  /// 4 logical pixels.
  static const double xs = 4.0;

  /// 8 logical pixels.
  static const double sm = 8.0;

  /// 12 logical pixels.
  static const double md = 12.0;

  /// 16 logical pixels.
  static const double lg = 16.0;

  /// 24 logical pixels.
  static const double xl = 24.0;

  /// 32 logical pixels.
  static const double xxl = 32.0;

  /// Gap between cards, down the page and across a row.
  static const double cardGap = 16.0;

  /// Corner radius of every card.
  static const double cardRadius = 24.0;

  /// Corner radius of tiles, fields and icon squares inside a card.
  static const double tileRadius = 16.0;

  /// A radius large enough to round any box into a pill.
  static const double pillRadius = 999.0;

  /// Widest the content next to the sidebar grows.
  static const double contentMaxWidth = 1180.0;

  /// Widest the dashboard grows; charts use the extra room.
  static const double dashboardMaxWidth = 1280.0;
}
