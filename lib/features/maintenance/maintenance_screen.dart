import 'package:society_managment/society_managment.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MaintenanceCubit>(
      create: (c) => MaintenanceCubit(context),
      child: const MaintenanceScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DefaultTabController(
      length: 4,
      child: _MaintenanceScaffold(l10n: l10n),
    );
  }
}

class _MaintenanceScaffold extends StatefulWidget {
  const _MaintenanceScaffold({required this.l10n});

  final AppLocalizations? l10n;

  @override
  State<_MaintenanceScaffold> createState() => _MaintenanceScaffoldState();
}

class _MaintenanceScaffoldState extends State<_MaintenanceScaffold> {
  bool _speedDialOpen = false;
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = DefaultTabController.of(context);
    if (_tabController != controller) {
      _tabController?.removeListener(_onTabChanged);
      _tabController = controller;
      _tabController?.addListener(_onTabChanged);
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (_speedDialOpen) {
      setState(() => _speedDialOpen = false);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = _tabController?.index ?? 0;
    final showSpeedDial = tabIndex == 0;
    final showConfirmFab = tabIndex == 3;
    final showFab = showSpeedDial || showConfirmFab;

    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Column(
            children: [
              MaintenanceHeader(showFilter: tabIndex == 3),
              Expanded(
                child: TabBarView(
                  children: [
                    BlocBuilder<MaintenanceCubit, MaintenanceState>(
                      builder: (context, state) {
                        final cubit = context.read<MaintenanceCubit>();
                        return OverviewBody(
                          state: state,
                          cubit: cubit,
                          l10n: widget.l10n,
                        );
                      },
                    ),
                    IncomeBody(l10n: widget.l10n),
                    ExpensesBody(l10n: widget.l10n),
                    MaintenanceTabBody(l10n: widget.l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_speedDialOpen && showSpeedDial)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _speedDialOpen = false),
              child: ColoredBox(color: AppColors.black.withValues(alpha: 0.45)),
            ),
          ),
        if (showFab)
          Positioned(
            right: 16.w,
            bottom: 16.h,
            child: showSpeedDial
                ? MaintenanceSpeedDial(
                    l10n: widget.l10n,
                    isOpen: _speedDialOpen,
                    onOpenChanged: (isOpen) =>
                        setState(() => _speedDialOpen = isOpen),
                  )
                : CommonFloatingActionButton(
                    onPressed: context
                        .read<MaintenanceCubit>()
                        .onMaintenanceFabPressed,
                    child: SvgAsset(
                      imagePath: AppAssets.tick,
                      height: 24.h,
                      color: AppColors.white,
                    ),
                  ),
          ),
      ],
    );
  }
}
