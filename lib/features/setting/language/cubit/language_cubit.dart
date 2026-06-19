import 'package:society_managment/society_management.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({Locale? initialLocale}) : super(LanguageState()) {
    final locale =
        initialLocale ??
        AppCubit.localeFromStorage(PrefService.getString(PrefKeys.localLanguage));
    final selectedLanguage =
        AppCubit.languageModelForLocale(locale, state.languages) ??
        state.languages.first;

    refresh(
      state.copyWith(
        selectedLanguage: selectedLanguage,
        initialLanguage: selectedLanguage,
      ),
    );
  }

  void refresh(LanguageState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void selectLanguage(LanguageModel lang) {
    refresh(state.copyWith(selectedLanguage: lang));
  }

  Future<void> updateLanguage(BuildContext context) async {
    final selectedLanguage = state.selectedLanguage;
    if (selectedLanguage == null || !state.hasLanguageChanged) {
      if (context.mounted) {
        context.navigator.pop();
      }
      return;
    }

    final locale = Locale(
      selectedLanguage.code,
      selectedLanguage.countryCode,
    );

    try {
      refresh(state.copyWith(loader: true));
      await context.read<AppCubit>().changeLanguage(locale);
      await WidgetsBinding.instance.endOfFrame;

      if (context.mounted) {
        context.navigator.pop();
      }
    } catch (e, stack) {
      showCatchToast(e, stack, msg: e.toString());
    } finally {
      refresh(state.copyWith(loader: false));
    }
  }
}
