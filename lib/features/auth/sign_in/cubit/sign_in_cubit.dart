import 'package:society_managment/society_managment.dart';
import 'package:society_managment/society_managment_extra.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  TextEditingController phoneNumberController = TextEditingController(
    text: kDebugMode ? "9876543210" : "",
  );

  void refresh(SignInState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onChangePhoneNumber(String value) {
    if (state.phoneNumberError.isNotEmpty) {
      refresh(state.copyWith(phoneNumberError: ""));
    }
  }

  void onCountryCodeChanged(String dialCode) {
    refresh(state.copyWith(countryCode: dialCode, phoneNumberError: ""));
    phoneNumberController.clear();
  }

  bool validation(BuildContext context) {
    final phone = phoneNumberController.text.trim();
    final minLength = CountryCodes.minPhoneLengthFor(state.countryCode);
    final maxLength = CountryCodes.maxPhoneLengthFor(state.countryCode);
    String phoneNumberError = "";

    if (phone.isEmpty) {
      phoneNumberError = context.l10n?.phoneNumberIsRequired ?? "";
    } else if (phone.length < minLength ||
        phone.length > maxLength ||
        !RegExp(r'^\d+$').hasMatch(phone)) {
      phoneNumberError = context.l10n?.phoneNumberIsInvalid ?? "";
    }

    refresh(state.copyWith(phoneNumberError: phoneNumberError));

    return phoneNumberError.isEmpty;
  }

  Future<void> onTapSignIn(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    final phone = phoneNumberController.text.trim();

    try {
      await AuthRepo.sendLoginOtp(phone: phone, countryCode: state.countryCode);

      if (!context.mounted) return;

      showSuccessToast(context.l10n?.otpSentSuccess ?? 'OTP sent successfully');

      context.navigator.pushNamed(
        OtpVerificationScreen.routeName,
        arguments: OtpVerificationArgs(
          phone: phone,
          countryCode: state.countryCode,
        ),
      );
    } catch (e) {
      showErrorToast(
        context.l10n?.somethingWentWrong ?? 'Something went wrong',
      );
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }
}
