import 'package:flutter/material.dart';

/// カード角丸・ピル形状・フレーム等、design.md 4章のビジュアル方針に沿った共通定数。
class AppRadii {
  AppRadii._();

  static const double card = 22;
  static const double cardMin = 20;
  static const double cardMax = 24;
  static const double pill = 999;
  static const double frame = 40;
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

/// コーラル系（クリーム×テラコッタ）の淡いトーンで統一したテーマ定義。
/// フラットデザイン方針（強い影・グラデーションの多用を避ける）に沿う。
class AppTheme {
  AppTheme._();

  static const Color _terracotta = Color(0xFFC97B63);
  static const Color _cream = Color(0xFFFBF3EA);
  static const Color _coral = Color(0xFFE8A798);

  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: _terracotta,
    brightness: Brightness.light,
    primary: _terracotta,
    surface: _cream,
    secondary: _coral,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: _terracotta,
    brightness: Brightness.dark,
    primary: const Color(0xFFE3A28D),
    secondary: const Color(0xFFCB8E7C),
  );

  static ThemeData get light => _build(_lightScheme);
  static ThemeData get dark => _build(_darkScheme);

  static ThemeData _build(ColorScheme scheme) {
    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.card),
    );
    final pillShape = const StadiumBorder();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      // フラットデザイン方針: 強い影を避ける
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerHighest,
        shape: cardShape,
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: pillShape,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: pillShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(shape: pillShape, elevation: 0),
      ),
      chipTheme: ChipThemeData(
        shape: pillShape,
        side: BorderSide.none,
        backgroundColor: scheme.surfaceContainerHighest,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.cardMin),
          borderSide: BorderSide.none,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }
}
