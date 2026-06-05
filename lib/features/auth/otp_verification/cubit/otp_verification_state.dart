part of 'otp_verification_cubit.dart';

class OtpVerificationState extends Equatable {
  const OtpVerificationState({
    this.isLoading = false,
    this.isOTPValidate = false,
    this.timer = 60,
    this.otpError = "",
  });

  final bool isLoading;
  final bool isOTPValidate;
  final int timer;
  final String otpError;

  OtpVerificationState copyWith({
    bool? isLoading,
    bool? isOTPValidate,
    int? timer,
    String? otpError,
  }) {
    return OtpVerificationState(
      isLoading: isLoading ?? this.isLoading,
      isOTPValidate: isOTPValidate ?? this.isOTPValidate,
      timer: timer ?? this.timer,
      otpError: otpError ?? this.otpError,
    );
  }

  @override
  List<Object?> get props => [isLoading, isOTPValidate, timer, otpError];
}
