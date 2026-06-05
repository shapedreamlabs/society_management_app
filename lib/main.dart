import 'package:society_managment/society_managment.dart';
import 'package:society_managment/society_managment_extra.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);

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
