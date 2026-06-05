part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.isLoading = false,
    this.phoneNumberError = "",
    this.countryCode = CountryCodes.defaultDialCode,
  });

  final bool isLoading;
  final String phoneNumberError;
  final String countryCode;

  SignInState copyWith({
    bool? isLoading,
    String? phoneNumberError,
    String? countryCode,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [isLoading, phoneNumberError, countryCode];
}
