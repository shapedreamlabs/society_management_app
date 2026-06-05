import 'package:society_managment/society_managment.dart';

class ErrorHandler {
  ErrorHandler._();

  static String handle(dynamic e, {bool showToast = true}) {
    String message = 'Something went wrong';

    if (e is AppException) {
      message = e.message;
    } else if (e is DioException) {
      message = _handleDioError(e);
    } else {
      final fallback = e.toString().trim();
      message = fallback.isEmpty ? 'Unexpected error occurred' : fallback;
    }

    if (showToast) {
      showErrorToast(message);
    }

    return message;
  }

  static String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout';

      case DioExceptionType.badResponse:
        return _extractServerMessage(e);

      case DioExceptionType.cancel:
        return 'Request cancelled';

      default:
        return 'Network error occurred';
    }
  }

  static String _extractServerMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return ApiResponseModel<dynamic>.fromJson(data).messageText;
      }
    } catch (_) {}

    return 'Server error occurred';
  }
}
