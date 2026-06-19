import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:society_managment/society_management.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState()) {
    init();
  }

  void refresh(AppState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void init() {
    final local = localeFromStorage(
      PrefService.getString(PrefKeys.localLanguage),
    );
    refresh(state.copyWith(locale: local));
    unawaited(_applyLocale(local));
  }

  Future<void> changeLanguage(Locale locale) async {
    await _applyLocale(locale);
    emit(state.copyWith(locale: locale));
    await PrefService.set(PrefKeys.localLanguage, localeToStorage(locale));
  }

  static Locale localeFromStorage(String stored) {
    if (stored.isEmpty) {
      return const Locale('en', 'US');
    }

    final normalized = stored.toLowerCase();
    if (normalized == 'english' || normalized == 'en_us' || normalized == 'en') {
      return const Locale('en', 'US');
    }
    if (normalized == 'gujarati' ||
        normalized == 'guj' ||
        normalized == 'gu_in' ||
        normalized == 'gu') {
      return const Locale('gu', 'IN');
    }
    if (normalized == 'hindi' ||
        normalized == 'hin' ||
        normalized == 'hi_in' ||
        normalized == 'hi') {
      return const Locale('hi', 'IN');
    }

    if (stored.contains('_')) {
      final parts = stored.split('_');
      return Locale(parts.first, parts.last);
    }

    return Locale(stored);
  }

  static String localeToStorage(Locale locale) {
    return '${locale.languageCode}_${locale.countryCode}';
  }

  static LanguageModel? languageModelForLocale(
    Locale locale,
    List<LanguageModel> languages,
  ) {
    return languages.firstWhereOrNull(
      (language) => language.code == locale.languageCode,
    );
  }

  Future<void> _applyLocale(Locale locale) async {
    final localeName = localeToStorage(locale);
    await initializeDateFormatting(localeName);
    Intl.defaultLocale = localeName;
  }
}
