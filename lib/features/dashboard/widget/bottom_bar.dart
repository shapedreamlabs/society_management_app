import 'package:society_managment/society_managment.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .only(
        top: 5.h,
        bottom: Platform.isIOS ? 0 : AppConstants.safeAreaPadding.bottom,
      ),
      color: AppColors.white,
      child: Container(
        margin: .only(bottom: 5.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          // border: Border(
          //   top: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.primary.withValues(alpha: 0.08),
          //     blurRadius: 18,
          //     offset: const Offset(0, -4),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            _SingleItem(
              index: 0,
              name: context.l10n?.home ?? "",
              activeIcon: AppAssets.homeFill,
              inactiveIcon: AppAssets.home,
            ),
            _SingleItem(
              index: 1,
              name: context.l10n?.directory ?? "",
              activeIcon: AppAssets.bookFill,
              inactiveIcon: AppAssets.book,
            ),
            _SingleItem(
              index: 2,
              name: context.l10n?.maintenance ?? "",
              activeIcon: AppAssets.maintenanceFill,
              inactiveIcon: AppAssets.maintenance,
            ),
            _SingleItem(
              index: 3,
              name: context.l10n?.visitor ?? "",
              activeIcon: AppAssets.profileFill,
              inactiveIcon: AppAssets.profile,
            ),
            _SingleItem(
              index: 4,
              name: context.l10n?.setting ?? "",
              activeIcon: AppAssets.settingFill,
              inactiveIcon: AppAssets.setting,
            ),
          ],
        ),
      ),
    );
  }
}

class _SingleItem extends StatelessWidget {
  const _SingleItem({
    required this.index,
    required this.name,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final int index;
  final String name;
  final String activeIcon;
  final String inactiveIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final bool isSelected = state.tabIndex == index;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.read<DashboardCubit>().onTabChanged(index),
              borderRadius: .circular(8.r),
              child: AnimatedSwitcher(
                duration: 200.milliseconds,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1).animate(animation),
                    child: child,
                  );
                },
                child: Column(
                  key: ValueKey<bool>(isSelected),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Space
                    14.h.spaceVertical,

                    /// Icon
                    SvgAsset(
                      imagePath: isSelected ? activeIcon : inactiveIcon,
                      height: 24.h,
                    ),

                    /// Space
                    6.h.spaceVertical,

                    /// Title
                    Text(
                      name,
                      style: (isSelected ? styleW700S12 : styleW400S12)
                          .copyWith(
                            color: AppColors.text.withValues(
                              alpha: isSelected ? 1 : 0.6,
                            ),
                          ),
                    ),

                    /// Space
                    14.h.spaceVertical,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
