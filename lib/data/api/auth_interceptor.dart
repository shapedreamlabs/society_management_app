import 'package:society_managment/society_management.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isLoggingOut = false;

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = PrefService.getString(PrefKeys.token);

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      if (!_isLoggingOut) {
        _isLoggingOut = true;
        _forceLogout();
      }
    }

    final exception = _mapDioError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  AppException _mapDioError(DioException err) {
    if (err.type == .connectionTimeout || err.type == .receiveTimeout) {
      return AppException(message: LocalizationLabels.connectionTimeout());
    }

    if (err.type == .connectionError) {
      return AppException(message: LocalizationLabels.noInternetConnection());
    }

    final status = err.response?.statusCode;

    switch (status) {
      case 400:
        return AppException(
          message: LocalizationLabels.badRequest(),
          statusCode: 400,
        );
      case 401:
        return AppException(
          message: LocalizationLabels.sessionExpired(),
          statusCode: 401,
        );
      case 403:
        return AppException(
          message: LocalizationLabels.accessDenied(),
          statusCode: 403,
        );
      case 404:
        return AppException(
          message: LocalizationLabels.resourceNotFound(),
          statusCode: 404,
        );
      case 500:
        return AppException(
          message: LocalizationLabels.serverError(),
          statusCode: 500,
        );
      default:
        return AppException(message: LocalizationLabels.somethingWentWrong());
    }
  }

  void _forceLogout() {
    /// Clear tokens / user session
    logoutUser();

    /// Optional: cancel all pending requests
    dio.close(force: true);
  }
}
