import 'package:society_managment/society_managment.dart';

/// Local auth helpers — no API calls until backend is ready.
class AuthRepo {
  AuthRepo._();

  static const _mockToken = 'mock_auth_token';

  static Future<void> _mockDelay() =>
      Future.delayed(const Duration(milliseconds: 600));

  /// Phone login step — simulates OTP sent (no network).
  static Future<void> sendLoginOtp({
    required String phone,
    required String countryCode,
  }) async {
    await _mockDelay();
  }

  /// Simulates resending OTP (no network).
  static Future<void> resendOtp({
    required String phone,
    required String countryCode,
  }) {
    return sendLoginOtp(phone: phone, countryCode: countryCode);
  }

  /// Verifies OTP locally and saves session (no network).
  static Future<UserModel> verifyOtp({
    required String phone,
    required String countryCode,
    required String otp,
  }) async {
    await _mockDelay();

    final user = UserModel(
      id: '1',
      name: 'User',
      phone: '$countryCode $phone'.trim(),
      email: '',
    );

    await PrefService.set(PrefKeys.token, _mockToken);
    await PrefService.set(PrefKeys.userData, userModelToJson(user));

    return user;
  }
}
