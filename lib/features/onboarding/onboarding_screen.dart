import 'package:society_managment/society_managment.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  static Widget builder(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (c) => OnboardingCubit(),
      child: const OnboardingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: .light,
          child: Scaffold(
            body: SafeArea(
              top: false,
              bottom: false,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AssetsImg(
                      imagePath: AppAssets.splashImg,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      constraints: BoxConstraints(minHeight: 0.3.sh),
                      padding: .all(AppConstants.horizontalPadding),
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: .start,
                        children: [
                          50.h.spaceVertical,

                          Text(
                            l10n?.manageEverythingInOnePlace ?? "",
                            textAlign: .start,
                            style: styleW700S38.copyWith(
                              color: AppColors.white,
                            ),
                          ),

                          10.h.spaceVertical,

                          Text(
                            l10n?.onBoardingContent ?? "",
                            textAlign: .start,
                            style: styleW400S16.copyWith(
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),

                          24.h.spaceVertical,

                          CustomButton(
                            title: l10n?.getStarted ?? "",
                            onTap: () => cubit.onTapGetStarted(context),
                          ),

                          0.h.spaceVertical,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
