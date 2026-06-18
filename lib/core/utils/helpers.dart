import 'package:society_managment/society_managment.dart';
import 'package:society_managment/society_managment_extra.dart';

void showErrorToast(String msg) {
  showCustomToast(msg, error: true);
}

void showSuccessToast(String msg) {
  showCustomToast(msg);
}

Future<void> showCatchToast(
  dynamic exception,
  StackTrace? stack, {
  String? msg,
}) async {
  bool isInternetOn = false;

  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isInternetOn = true;
      debugPrint('connected');
    }
  } on SocketException catch (_) {
    debugPrint('not connected');
  }

  String content = "";

  if (!isInternetOn) {
    content = LocalizationLabels.checkInternetConnection();
  } else if (kDebugMode) {
    content = msg ?? exception.toString();
  } else {
    content = LocalizationLabels.somethingWentWrong();
  }

  showErrorToast(content);
}

bool isEnglishSelected() {
  final stored = PrefService.getString(PrefKeys.localLanguage);
  if (stored.isEmpty) {
    return true;
  }

  return AppCubit.localeFromStorage(stored).languageCode == 'en';
}
