import 'dart:math';

import 'package:society_managment/society_managment.dart';

class AppColors {
  static const Color primary = Color(0xFFFFA565);
  static const Color booked = Color(0xFF701DA1);
  static const Color text = Color(0xFF15161A);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFD51717);
  static const Color logoutRed = Color(0xFFFA5753);
  static const Color chartIncomeGreen = Color(0xFF6AAF6A);
  static const Color chartExpenseRed = Color(0xFFFA5753);
  static const Color darkRed = Color(0xFFAD3234);
  static const Color bgColor = Color(0xFFfaf7f3);
  static const Color blue = Color(0xFF1E2A3A);
  static const Color darkBlue = Color(0xFF3242AD);
  static const Color orange = Color(0xFFC4793A);
  static const Color fabShadowColor = Color(0x3DC4793A);
  static const List<BoxShadow> fabBoxShadow = [
    BoxShadow(
      color: fabShadowColor,
      blurRadius: 14,
      spreadRadius: 2,
      offset: Offset.zero,
    ),
  ];
  static const Color grey = Color(0xFF5C5F68);
  static const Color grey1 = Color(0xFF2A3A0A);
  static const Color skyBlue = Color(0xFF65B4FF);
  static const Color peach = primary;
  static const Color goldenYellow = Color(0xFFFFD265);

  static Color get inputEnabledBorder => text.withValues(alpha: 0.12);
  static Color get inputFocusedBorder => primary;
  static Color get inputErrorBorder => red;
  static Color get inputDisabledBorder => text.withValues(alpha: 0.06);

  ///
  static MaterialColor generateMaterialColor() {
    return MaterialColor(primary.hashCode, {
      50: tintColor(primary, 0.9),
      100: tintColor(primary, 0.8),
      200: tintColor(primary, 0.6),
      300: tintColor(primary, 0.4),
      400: tintColor(primary, 0.2),
      500: primary,
      600: shadeColor(primary, 0.1),
      700: shadeColor(primary, 0.2),
      800: shadeColor(primary, 0.3),
      900: shadeColor(primary, 0.4),
    });
  }

  static int tintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static Color tintColor(Color color, double factor) {
    return Color.fromARGB(
      _extractAlpha(color),
      _adjustTintValue(_extractRed(color), factor),
      _adjustTintValue(_extractGreen(color), factor),
      _adjustTintValue(_extractBlue(color), factor),
    );
  }

  static int shadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  static Color shadeColor(Color color, double factor) {
    return Color.fromARGB(
      _extractAlpha(color),
      _adjustShadeValue(_extractRed(color), factor),
      _adjustShadeValue(_extractGreen(color), factor),
      _adjustShadeValue(_extractBlue(color), factor),
    );
  }

  static int _extractAlpha(Color color) => (color.hashCode >> 24) & 0xFF;

  static int _adjustTintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static int _adjustShadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  static int _extractRed(Color color) => (color.hashCode >> 16) & 0xFF;

  static int _extractGreen(Color color) => (color.hashCode >> 8) & 0xFF;

  static int _extractBlue(Color color) => color.hashCode & 0xFF;

  /// THEME DATA
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    primarySwatch: generateMaterialColor(),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    useMaterial3: true,
    fontFamily: AppAssets.outfit,
    scaffoldBackgroundColor: bgColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,
      hintStyle: TextStyle(color: grey, fontFamily: AppAssets.outfit),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: inputEnabledBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: inputFocusedBorder, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: red, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: inputDisabledBorder),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: inputEnabledBorder),
      ),
    ),
  );
}
