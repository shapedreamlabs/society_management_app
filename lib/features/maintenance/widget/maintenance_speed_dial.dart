import 'package:society_managment/society_managment.dart';

class MaintenanceSpeedDial extends StatelessWidget {
  const MaintenanceSpeedDial({
    super.key,
    required this.l10n,
    required this.isOpen,
    required this.onOpenChanged,
  });

  final AppLocalizations? l10n;
  final bool isOpen;
  final ValueChanged<bool> onOpenChanged;

  static const List<String> _routes = [
    AddMaintenanceReminderScreen.routeName,
    AddIncomeScreen.routeName,
    AddExpenseScreen.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    final actions = [
      l10n?.addMaintenanceReminder ?? '',
      l10n?.addIncome ?? '',
      l10n?.addExpenses ?? '',
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isOpen) ...[
          for (var index = 0; index < actions.length; index++) ...[
            _SpeedDialAction(
              label: actions[index],
              onTap: () => _onActionTap(context, index),
            ),
            12.h.spaceVertical,
          ],
        ],
        CommonFloatingActionButton(
          onPressed: () => onOpenChanged(!isOpen),
          child: SvgAsset(
            imagePath: isOpen ? AppAssets.close : AppAssets.add,
            height: 24.h,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  void _onActionTap(BuildContext context, int index) {
    onOpenChanged(false);
    context.navigator.pushNamed(_routes[index]);
  }
}

class _SpeedDialAction extends StatelessWidget {
  const _SpeedDialAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.text.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(label, style: styleW500S14),
        ),
      ),
    );
  }
}
