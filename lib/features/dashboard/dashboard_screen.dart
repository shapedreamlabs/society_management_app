import 'package:society_managment/society_managment.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const routeName = "/dashboard";

  static Widget builder(BuildContext context) {
    final initialIndex = context.args is int ? context.args as int : null;

    return BlocProvider<DashboardCubit>(
      create: (c) => DashboardCubit(context, initialIndex),
      child: const DashboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.locale != current.locale,
          builder: (context, appState) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;

                if (state.tabIndex == 0) {
                  openSureToExitBottomSheet(context);
                } else {
                  context.read<DashboardCubit>().onTabChanged(0);
                }
              },
              child: Scaffold(
                drawer: MenuDrawer(key: ValueKey(appState.locale)),
                appBar: state.tabIndex == 0
                    ? CommonDashAppBar(
                        key: ValueKey(appState.locale),
                        showSearchBar: true,
                      )
                    : null,
                bottomNavigationBar: BottomBar(key: ValueKey(appState.locale)),
                body: AnimatedSwitcher(
                  duration: 200.milliseconds,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Builder(
                    key: ValueKey('${state.tabIndex}_${appState.locale}'),
                    builder: (context) {
                      if (state.tabIndex == 0) {
                        return HomeScreen.builder(context);
                      } else if (state.tabIndex == 1) {
                        return DirectoryScreen.builder(context);
                      } else if (state.tabIndex == 2) {
                        return MaintenanceScreen.builder(context);
                      } else if (state.tabIndex == 3) {
                        return MainVisitorScreen.builder(context);
                      }
                      return SettingScreen.builder(context);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
