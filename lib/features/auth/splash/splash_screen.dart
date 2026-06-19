import 'package:society_managment/society_management.dart';

bool _splashInit = false;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  static Widget builder(BuildContext context) {
    return SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    onRedirectNext(context);

    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Center(child: AppBrandLogo(dimension: 168.h)),
    );
  }

  Future<void> onRedirectNext(BuildContext context) async {
    if (_splashInit) return;

    try {
      _splashInit = true;

      await Future.delayed(2.seconds);
      FlutterNativeSplash.remove();

      bool isOnboardingDone = PrefService.getBool(PrefKeys.isBoarding);
      bool isLoggedIn = PrefService.getBool(PrefKeys.isLoggedIn);

      if (context.mounted) {
        if (isLoggedIn) {
          context.navigator.pushNamedAndRemoveUntil(
            DashboardScreen.routeName,
            (p) => false,
          );
        } else {
          if (!isOnboardingDone) {
            PrefService.set(PrefKeys.isBoarding, true);
            context.navigator.pushNamedAndRemoveUntil(
              OnboardingScreen.routeName,
              (p) => false,
            );
          } else {
            context.navigator.pushNamedAndRemoveUntil(
              SignInScreen.routeName,
              (p) => false,
            );
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
