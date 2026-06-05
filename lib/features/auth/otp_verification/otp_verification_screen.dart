import 'package:society_managment/society_managment.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  static const routeName = '/otp_verification';

  static Widget builder(BuildContext context) {
    final args = OtpVerificationArgs.fromRouteArgs(context.args);

    if (args == null) {
      return const UnknownScreen();
    }

    return BlocProvider<OtpVerificationCubit>(
      create: (c) => OtpVerificationCubit(args),
      child: const OtpVerificationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
      builder: (context, state) {
        final cubit = context.read<OtpVerificationCubit>();

        return Scaffold(
          appBar: CustomAppBar(title: l10n?.otpVerification ?? ""),
          bottomNavigationBar: Container(
            color: AppColors.bgColor,
            margin: .all(20.h),
            child: CustomButton(
              title: l10n?.verifyContinue ?? "",
              isDisabled: !state.isOTPValidate,
              isLoading: state.isLoading,
              onTap: () => cubit.onTapVerifyOTP(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: .symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Space
                34.h.spaceVertical,

                RichText(
                  textAlign: .center,
                  text: TextSpan(
                    style: styleW400S16,
                    children: [
                      TextSpan(text: l10n?.otpSentMessagePrefix ?? ""),
                      TextSpan(
                        text: cubit.args.formattedPhone,
                        style: styleW500S16,
                      ),
                      TextSpan(text: l10n?.otpSentMessageSuffix ?? ""),
                    ],
                  ),
                ),

                // Space
                32.h.spaceVertical,

                Pinput(
                  length: 6,
                  controller: cubit.otpController,
                  onCompleted: (_) => cubit.onTapVerifyOTP(context),
                  onSubmitted: (_) => cubit.onTapVerifyOTP(context),
                  onChanged: cubit.onOtpChanged,
                  autofocus: true,
                  defaultPinTheme: _pinTheme(),
                  disabledPinTheme: _pinTheme(),
                  focusedPinTheme: _pinTheme().copyWith(
                    decoration: _pinTheme().decoration?.copyWith(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.orange),
                    ),
                  ),
                  submittedPinTheme: _pinTheme().copyWith(
                    decoration: _pinTheme().decoration?.copyWith(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.orange),
                    ),
                  ),
                  errorPinTheme: _pinTheme().copyWith(
                    decoration: _pinTheme().decoration?.copyWith(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.red),
                    ),
                  ),
                ),
                if (state.otpError.isNotEmpty) ...[
                  8.h.spaceVertical,
                  ErrorText(error: state.otpError, isCenterAlign: true),
                ],

                // Space
                32.h.spaceVertical,

                BlocSelector<OtpVerificationCubit, OtpVerificationState, int>(
                  selector: (otpState) => otpState.timer,
                  builder: (context, timer) {
                    if (timer == 0) {
                      return Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            l10n?.didntYouReceiveAnyCode ?? "",
                            style: styleW400S14.copyWith(
                              color: AppColors.text.withValues(alpha: 0.8),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: .circular(8.r),
                              onTap: state.isLoading
                                  ? null
                                  : () => cubit.onTapResendCode(context),
                              child: Padding(
                                padding: .symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  l10n?.resendCode ?? "",
                                  style: styleW600S14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return Text(
                      l10n?.resendCodeIn(
                            '${(timer / 60).floor().toString().padLeft(2, '0')}:${(timer % 60).toString().padLeft(2, '0')}',
                          ) ??
                          '',
                      textAlign: .center,
                      style: styleW400S14.copyWith(
                        color: AppColors.text.withValues(alpha: 0.8),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PinTheme _pinTheme() {
    return PinTheme(
      width: 48.w,
      height: 48.w,
      textStyle: styleW500S16,
      decoration: BoxDecoration(
        borderRadius: .circular(8.r),
        color: AppColors.white,
        border: Border.all(color: AppColors.text.withValues(alpha: 0.1)),
      ),
    );
  }
}
