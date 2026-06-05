import 'package:society_managment/society_managment.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit(this.args) : super(const OtpVerificationState()) {
    startTimer();
  }

  final OtpVerificationArgs args;
  Timer? timer;
  final TextEditingController otpController = TextEditingController();

  void refresh(OtpVerificationState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void startTimer() {
    timer?.cancel();
    refresh(state.copyWith(timer: 60));
    timer = Timer.periodic(const Duration(seconds: 1), (activeTimer) {
      if (state.timer == 0) {
        activeTimer.cancel();
      } else {
        refresh(state.copyWith(timer: state.timer - 1));
      }
    });
  }

  void onOtpChanged(String value) {
    refresh(
      state.copyWith(
        isOTPValidate: value.length == 6,
        otpError: value.isEmpty ? state.otpError : "",
      ),
    );
  }

  Future<void> onTapResendCode(BuildContext context) async {
    if (state.timer > 0) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      await AuthRepo.resendOtp(
        phone: args.phone,
        countryCode: args.countryCode,
      );

      if (!context.mounted) return;

      showSuccessToast(context.l10n?.otpSentSuccess ?? '');
      otpController.clear();
      refresh(state.copyWith(isOTPValidate: false, otpError: ""));
      startTimer();
    } catch (e) {
      showErrorToast(
        context.l10n?.somethingWentWrong ?? '',
      );
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }

  bool _validateOtp(BuildContext context) {
    final otp = otpController.text.trim();
    String otpError = "";

    if (otp.isEmpty) {
      otpError = context.l10n?.otpIsRequired ?? "";
    } else if (otp.length != 6) {
      otpError = context.l10n?.otpIsInvalid ?? "";
    }

    refresh(state.copyWith(otpError: otpError));

    return otpError.isEmpty;
  }

  Future<void> onTapVerifyOTP(BuildContext context) async {
    if (!_validateOtp(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      await AuthRepo.verifyOtp(
        phone: args.phone,
        countryCode: args.countryCode,
        otp: otpController.text.trim(),
      );

      await PrefService.set(PrefKeys.isLoggedIn, true);

      if (!context.mounted) return;

      showSuccessToast(context.l10n?.loginSuccess ?? '');

      context.navigator.pushNamedAndRemoveUntil(
        DashboardScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showErrorToast(
        context.l10n?.somethingWentWrong ?? '',
      );
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    otpController.dispose();
    return super.close();
  }
}
