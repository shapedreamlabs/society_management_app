part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final bool loader;
  final LanguageModel? selectedLanguage;
  final LanguageModel? initialLanguage;
  final List<LanguageModel> languages;

  LanguageState({
    this.loader = false,
    LanguageModel? selectedLanguage,
    LanguageModel? initialLanguage,
    List<LanguageModel>? languages,
  }) : languages =
           languages ??
           [
             LanguageModel(
               code: 'en',
               countryCode: 'US',
               title: 'EN_US',
               label: 'English (United States)',
             ),
             LanguageModel(
               code: 'gu',
               countryCode: 'IN',
               title: 'GUJ',
               label: 'Gujarati',
             ),
             LanguageModel(
               code: 'hi',
               countryCode: 'IN',
               title: 'HIN',
               label: 'Hindi',
             ),
           ],
       selectedLanguage =
           selectedLanguage ??
           LanguageModel(
             code: 'en',
             countryCode: 'US',
             title: 'EN_US',
             label: 'English',
           ),
       initialLanguage =
           initialLanguage ??
           selectedLanguage ??
           LanguageModel(
             code: 'en',
             countryCode: 'US',
             title: 'EN_US',
             label: 'English',
           );

  bool get hasLanguageChanged =>
      selectedLanguage?.code != initialLanguage?.code;

  LanguageState copyWith({
    bool? loader,
    LanguageModel? selectedLanguage,
    LanguageModel? initialLanguage,
    List<LanguageModel>? languages,
  }) {
    return LanguageState(
      loader: loader ?? this.loader,
      languages: languages ?? this.languages,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      initialLanguage: initialLanguage ?? this.initialLanguage,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    languages,
    selectedLanguage,
    initialLanguage,
  ];
}
