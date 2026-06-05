import 'package:society_managment/society_managment.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign_in';

  static Widget builder(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (c) => SignInCubit(),
      child: const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;

            // openSureToExitBottomSheet(context);
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: .light,
            child: Scaffold(
              bottomNavigationBar: Container(
                color: AppColors.white,
                margin: .all(20.h),
                child: CustomButton(
                  title: l10n?.login ?? "",
                  isLoading: state.isLoading,
                  onTap: () => cubit.onTapSignIn(context),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: .symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.h.spaceVertical,

                      Text(l10n?.loginNow ?? "", style: styleW500S30),

                      10.h.spaceVertical,

                      Text(
                        l10n?.loginContent ?? "",
                        style: styleW400S16.copyWith(
                          color: AppColors.text.withValues(alpha: 0.8),
                        ),
                      ),

                      24.h.spaceVertical,

                      AppPhoneTextField(
                        controller: cubit.phoneNumberController,
                        header: l10n?.phoneNumber,
                        hintText: l10n?.enterPhoneNumber,
                        error: state.phoneNumberError,
                        countryCode: state.countryCode,
                        onChanged: cubit.onChangePhoneNumber,
                        onCountryCodeChanged: cubit.onCountryCodeChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
