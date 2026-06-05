import 'package:society_managment/society_managment.dart';

class AppConstants {
  static const double figmaPageHeight = 852;
  static const double figmaPageWidth = 393;
  static const Size figmaSize = Size(figmaPageWidth, figmaPageHeight);
  static double deviceHeight = 0;
  static double deviceWidth = 0;
  static EdgeInsets safeAreaPadding = EdgeInsets.zero;
  static double horizontalPadding = 20.w;

  static const String appName = "Society Management";

  /// Sample lists (notices, bookings, etc.) until backend APIs are wired.
  /// Set to false when real API data is available.
  static const bool useMockData = true;
}
