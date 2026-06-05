import 'package:society_managment/core/constants/country_codes.dart';

class OtpVerificationArgs {
  const OtpVerificationArgs({required this.phone, required this.countryCode});

  final String phone;
  final String countryCode;

  String get formattedPhone {
    final digits = phone.trim();
    if (digits.length >= 10) {
      return '$countryCode ${digits.substring(0, 5)} ${digits.substring(5)}';
    }
    return '$countryCode $digits';
  }

  static OtpVerificationArgs? fromRouteArgs(Object? args) {
    if (args is OtpVerificationArgs) {
      return args;
    }

    if (args is Map<String, dynamic>) {
      final phone = args['phone']?.toString() ?? '';
      final countryCode =
          args['countryCode']?.toString() ?? CountryCodes.defaultDialCode;
      if (phone.isEmpty) {
        return null;
      }
      return OtpVerificationArgs(phone: phone, countryCode: countryCode);
    }

    return null;
  }
}
