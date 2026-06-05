part of 'setting_cubit.dart';

class SettingState extends Equatable {
  const SettingState({
    this.isLoading = false,
    this.settings = const [],
    this.name = "",
    this.phone = "",
    this.avatar = "",
  });

  final bool isLoading;
  final List<SettingsModel> settings;
  final String name;
  final String phone;
  final String avatar;

  SettingState copyWith({
    bool? isLoading,
    List<SettingsModel>? settings,
    String? name,
    String? phone,
    String? avatar,
  }) {
    return SettingState(
      isLoading: isLoading ?? this.isLoading,
      settings: settings ?? this.settings,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  List<Object?> get props => [isLoading, settings, name, phone, avatar];
}
