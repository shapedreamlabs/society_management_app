import 'package:society_managment/society_managment.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(BuildContext context) : super(SettingState()) {
    init(context);
    _syncProfileAndRefresh();
  }

  void refresh(SettingState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void init(BuildContext context) {
    final settings = [
      SettingsModel(
        title: context.l10n?.myProfile ?? "",
        icon: AppAssets.myProfile,
        onTap: () => context.navigator.pushNamed(MyProfileScreen.routeName),
      ),

      SettingsModel(
        title: context.l10n?.familyMembers ?? "",
        icon: AppAssets.family,
        onTap: () => context.navigator.pushNamed(FamilyMembersScreen.routeName),
      ),

      SettingsModel(
        title: context.l10n?.language ?? "",
        icon: AppAssets.language,
        onTap: () => context.navigator.pushNamed(LanguageScreen.routeName),
      ),

      SettingsModel(
        title: context.l10n?.logOut ?? "",
        icon: AppAssets.logout,
        onTap: () => onTapLogout(context),
      ),
    ];

    refresh(
      state.copyWith(
        settings: settings,
        name: userModel?.name ?? "User",
        phone: userModel?.phone ?? "",
        avatar: userModel?.image ?? "",
      ),
    );
  }

  Future<void> _syncProfileAndRefresh() async {
    try {
      refresh(
        state.copyWith(
          name: userModel?.name ?? "User",
          phone: userModel?.phone ?? "",
          avatar: userModel?.image ?? "",
        ),
      );
    } catch (_) {}
  }
}
