part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({this.locale = const Locale('en', 'US')});

  final Locale locale;

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('gu', 'IN'),
    Locale('hi', 'IN'),
  ];

  AppState copyWith({Locale? locale}) {
    return AppState(locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];
}
