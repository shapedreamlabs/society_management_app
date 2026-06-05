import 'package:society_managment/society_managment.dart';

class MaintenanceSpeedDial extends StatefulWidget {
  const MaintenanceSpeedDial({
    super.key,
    required this.l10n,
    required this.isOpen,
    required this.onOpenChanged,
  });

  final AppLocalizations? l10n;
  final bool isOpen;
  final ValueChanged<bool> onOpenChanged;

  @override
  State<MaintenanceSpeedDial> createState() => _MaintenanceSpeedDialState();
}

class _MaintenanceSpeedDialState extends State<MaintenanceSpeedDial>
    with SingleTickerProviderStateMixin {
  static const List<String> _routes = [
    AddMaintenanceReminderScreen.routeName,
    AddIncomeScreen.routeName,
    AddExpenseScreen.routeName,
  ];

  static const _duration = Duration(milliseconds: 250);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    if (widget.isOpen) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(MaintenanceSpeedDial oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onActionTap(BuildContext context, int index) {
    widget.onOpenChanged(false);
    context.navigator.pushNamed(_routes[index]);
  }

  Animation<double> _actionAnimation(int index) {
    final start = index * 0.12;
    final end = (0.55 + index * 0.12).clamp(0.0, 1.0);

    return CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
      reverseCurve: Interval(start, end, curve: Curves.easeInCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      widget.l10n?.addMaintenanceReminder ?? '',
      widget.l10n?.addIncome ?? '',
      widget.l10n?.addExpenses ?? '',
    ];
    final showActions = widget.isOpen || _controller.value > 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showActions)
          for (var index = 0; index < actions.length; index++)
            AnimatedBuilder(
              animation: _actionAnimation(index),
              builder: (context, child) {
                final animation = _actionAnimation(index);

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.35),
                      end: Offset.zero,
                    ).animate(animation),
                    child: IgnorePointer(
                      ignoring: animation.value < 0.5,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: child,
                      ),
                    ),
                  ),
                );
              },
              child: _SpeedDialAction(
                label: actions[index],
                onTap: () => _onActionTap(context, index),
              ),
            ),
        CommonFloatingActionButton(
          onPressed: () => widget.onOpenChanged(!widget.isOpen),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 0.785398,
                child: AnimatedSwitcher(
                  duration: _duration,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: SvgAsset(
                    key: ValueKey(widget.isOpen),
                    imagePath: widget.isOpen
                        ? AppAssets.close
                        : AppAssets.add,
                    height: 24.h,
                    color: AppColors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
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
