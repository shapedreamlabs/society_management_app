import 'package:society_managment/society_managment.dart';

class MaintenanceHeader extends StatelessWidget {
  const MaintenanceHeader({super.key, this.showFilter = false});

  final bool showFilter;

  Future<void> _openFilterSheet(BuildContext context) async {
    final cubit = context.read<MaintenanceCubit>();
    final l10n = context.l10n;
    final state = cubit.state;

    const filters = MaintenanceMemberFilter.values;
    final labels = [
      l10n?.all ?? '',
      l10n?.pending ?? '',
      l10n?.completed ?? '',
    ];

    final selectedIndex = await AppBottomSheet.show<int>(
      context: context,
      title: l10n?.filter,
      child: ListView.separated(
        shrinkWrap: true,
        padding: .symmetric(vertical: 8.h),
        itemCount: filters.length,
        separatorBuilder: (_, _) =>
            Divider(height: 1, color: AppColors.text.withValues(alpha: 0.08)),
        itemBuilder: (context, index) {
          final isSelected = filters[index] == state.memberFilter;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.navigator.pop(index),
              child: Padding(
                padding: .symmetric(horizontal: 20.w, vertical: 14.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        labels[index],
                        style: styleW500S14.copyWith(
                          color: isSelected ? AppColors.orange : AppColors.text,
                        ),
                      ),
                    ),
                    if (isSelected)
                      SvgAsset(imagePath: AppAssets.tick, height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    if (selectedIndex != null) {
      cubit.onMemberFilterChanged(filters[selectedIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      color: AppColors.blue,
      padding: EdgeInsets.fromLTRB(
        AppConstants.horizontalPadding,
        MediaQuery.of(context).padding.top + 14.h,
        AppConstants.horizontalPadding,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n?.maintenance ?? '',
                  style: styleW700S24.copyWith(color: AppColors.white),
                ),
              ),
              if (showFilter)
                CustomIconButton(
                  icon: AppAssets.filter,
                  size: 22.h,
                  padding: 8.w,
                  onTap: () => _openFilterSheet(context),
                ),
            ],
          ),
          8.h.spaceVertical,
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.orange,
            unselectedLabelColor: AppColors.white.withValues(alpha: 0.7),
            labelStyle: styleW500S14,
            unselectedLabelStyle: styleW500S14,
            indicatorColor: AppColors.orange,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: l10n?.overview ?? ''),
              Tab(text: l10n?.income ?? ''),
              Tab(text: l10n?.expenses ?? ''),
              Tab(text: l10n?.maintenance ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
