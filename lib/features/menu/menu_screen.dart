import 'package:society_managment/society_managment.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const routeName = '/menu';

  static Widget builder(BuildContext context) {
    return const MenuScreen();
  }

  List<MenuItemModel> _menuItems(AppLocalizations? l10n) {
    return [
      MenuItemModel(
        title: l10n?.notices ?? "",
        iconPath: AppAssets.notices,
        routeName: NoticesScreen.routeName,
      ),
      MenuItemModel(
        title: l10n?.emergencyAlerts ?? "",
        iconPath: AppAssets.emergencyBW,
        routeName: EmergencyAlertsScreen.routeName,
      ),
      MenuItemModel(
        title: l10n?.complaints ?? "",
        iconPath: AppAssets.complains,
        routeName: ComplaintsScreen.routeName,
      ),
      MenuItemModel(
        title: l10n?.banquetHall ?? "",
        iconPath: AppAssets.banquetHallBW,
        isImage: true,
        routeName: BanquetHallScreen.routeName,
      ),
      MenuItemModel(
        title: l10n?.vehicleLookup ?? "",
        iconPath: AppAssets.vehicle,
        routeName: VehicleLookupScreen.routeName,
      ),
      MenuItemModel(
        title: l10n?.createNewUser ?? "",
        iconPath: AppAssets.roundedAdd,
        routeName: CreateNewUserScreen.routeName,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _menuItems(context.l10n);

    return MenuListLayout(
      items: items,
      onItemTap: (item, _) {
        final route = item.routeName;
        if (route != null && route.isNotEmpty) {
          context.navigator.pushNamed(route);
        }
      },
    );
  }
}
