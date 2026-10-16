import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The app theme: white cards on a pale lavender page, black pill buttons
/// and soft lavender, sky and mint accents, set in Inter.
abstract final class AppTheme {
  static const String _font = 'Inter';

  static const Color _page = Color(0xFFF5F4F9);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _ink = Color(0xFF1C1B22);
  static const Color _muted = Color(0xFF6E6B7B);
  static const Color _line = Color(0xFFECEAF2);
  static const Color _tint = Color(0xFFF1EFF7);
  static const Color _accent = Color(0xFF6E56CF);
  static const Color _lavender = Color(0xFFE8E3FA);
  static const Color _onLavender = Color(0xFF3B2C86);
  static const Color _mint = Color(0xFFE0EEE3);
  static const Color _onMint = Color(0xFF1E4D2D);
  static const Color _sky = Color(0xFFDCEAF6);
  static const Color _onSky = Color(0xFF1E3F5E);
  static const Color _danger = Color(0xFFB42332);
  static const Color _rose = Color(0xFFFBE4E8);
  static const Color _onRose = Color(0xFF8F1D2C);

  /// First colour of the gradient behind every screen.
  static const Color backdropStart = Color(0xFFE9ECF8);

  /// Middle colour of the gradient behind every screen.
  static const Color backdropMiddle = Color(0xFFF0ECF9);

  /// Last colour of the gradient behind every screen.
  static const Color backdropEnd = Color(0xFFF9EBF0);

  /// Last colour of the gradient behind every screen.
  static const Color peachGlowStart = Color(0x66FFD8C4);

  /// Last colour of the gradient behind every screen.
  static const Color peachGlowEnd = Color(0x00FFD8C4);

  static const double _dialogRadius = 28.0;
  static const double _buttonHeight = 44.0;
  static const double _focusedBorderWidth = 1.5;
  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
    horizontal: 22.0,
    vertical: 14.0,
  );

  // Letter spacing per size, tighter the larger the type.
  static const double _displayTracking = -1.5;
  static const double _headlineLargeTracking = -1.0;
  static const double _headlineMediumTracking = -0.8;
  static const double _headlineSmallTracking = -0.5;
  static const double _titleLargeTracking = -0.4;
  static const double _titleMediumTracking = -0.2;
  static const double _bodyLargeTracking = -0.1;

  /// Inter's weights and tighter tracking on the large sizes, as in the
  /// design: big headings read set close, small text keeps its spacing.
  static const TextTheme _typeScale = TextTheme(
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: _displayTracking,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: _headlineLargeTracking,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: _headlineMediumTracking,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w600,
      letterSpacing: _headlineSmallTracking,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      letterSpacing: _titleLargeTracking,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      letterSpacing: _titleMediumTracking,
    ),
    titleSmall: TextStyle(fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(letterSpacing: _bodyLargeTracking),
    bodyMedium: TextStyle(letterSpacing: 0.0),
    bodySmall: TextStyle(letterSpacing: 0.0),
    labelLarge: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.0),
    labelMedium: TextStyle(letterSpacing: 0.0),
  );

  /// The light theme, the only one the app has.
  static ThemeData light() {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: _accent)
        .copyWith(
          primary: _accent,
          onPrimary: _card,
          primaryContainer: _lavender,
          onPrimaryContainer: _onLavender,
          secondaryContainer: _mint,
          onSecondaryContainer: _onMint,
          tertiaryContainer: _sky,
          onTertiaryContainer: _onSky,
          error: _danger,
          errorContainer: _rose,
          onErrorContainer: _onRose,
          surface: _card,
          onSurface: _ink,
          onSurfaceVariant: _muted,
          outlineVariant: _line,
          surfaceContainerLowest: _card,
          surfaceContainerLow: _page,
          surfaceContainerHighest: _tint,
          inverseSurface: _ink,
          onInverseSurface: _card,
        );
    final TextTheme text = ThemeData(
      colorScheme: scheme,
      fontFamily: _font,
    ).textTheme.merge(_typeScale);
    final ButtonStyle pill = _pillButton(text);
    final BorderRadius tile = BorderRadius.circular(AppSpacing.tileRadius);

    return ThemeData(
      colorScheme: scheme,
      fontFamily: _font,
      textTheme: text,
      scaffoldBackgroundColor: _page,
      dividerTheme: const DividerThemeData(color: _line, space: 1.0),
      iconTheme: const IconThemeData(color: _ink),
      cardTheme: CardThemeData(
        color: _card,
        elevation: 0.0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _ink,
          foregroundColor: _card,
          disabledBackgroundColor: _tint,
          disabledForegroundColor: _muted,
        ).merge(pill),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _ink,
          backgroundColor: _card,
          side: const BorderSide(color: _line),
        ).merge(pill),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: _ink).merge(pill),
      ),
      inputDecorationTheme: _inputTheme(text),
      dialogTheme: DialogThemeData(
        backgroundColor: _card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_dialogRadius),
        ),
        titleTextStyle: text.headlineSmall,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _ink,
        contentTextStyle: text.bodyMedium?.copyWith(color: _card),
        shape: RoundedRectangleBorder(borderRadius: tile),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: _ink,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        textStyle: text.bodySmall?.copyWith(color: _card),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _accent,
        linearTrackColor: _lavender,
        circularTrackColor: Colors.transparent,
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        shape: Border(),
        collapsedShape: Border(),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _card,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  /// What every button shares: pill shape, height, padding and label.
  static ButtonStyle _pillButton(TextTheme text) => ButtonStyle(
    minimumSize: const WidgetStatePropertyAll<Size>(
      Size(0.0, _buttonHeight),
    ),
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(_buttonPadding),
    shape: const WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder()),
    textStyle: WidgetStatePropertyAll<TextStyle?>(text.labelLarge),
  );

  /// White fields with a hairline border that turns lavender on focus.
  static InputDecorationThemeData _inputTheme(TextTheme text) =>
      InputDecorationThemeData(
        filled: true,
        fillColor: _card,
        hintStyle: text.bodyLarge?.copyWith(color: _muted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: _fieldBorder(_line),
        enabledBorder: _fieldBorder(_line),
        disabledBorder: _fieldBorder(_line),
        focusedBorder: _fieldBorder(_accent, width: _focusedBorderWidth),
      );

  static OutlineInputBorder _fieldBorder(Color color, {double width = 1.0}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
        borderSide: BorderSide(color: color, width: width),
      );
}
