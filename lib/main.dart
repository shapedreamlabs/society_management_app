import 'package:society_managment/society_management.dart';
import 'package:society_managment/society_management_extra.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      );

      await PrefService.init();
      await ScreenUtil.ensureScreenSize();

      runApp(AppView());
    },
    (error, stack) {
      if (kDebugMode) {
        // log("error==========>>>>>>>>>\n$error");
        // log("stack==========>>>>>>>>>\n$stack");
      }
    },
  );
}
