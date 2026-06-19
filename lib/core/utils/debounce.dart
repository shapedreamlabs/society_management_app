import 'package:society_managment/society_management.dart';

/// Debounce
class Debounce {
  /// Debounce
  Debounce({required this.milliseconds});

  /// milliseconds
  final int milliseconds;
  Timer? _timer;

  /// run
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
