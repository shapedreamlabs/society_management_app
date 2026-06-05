import 'package:society_managment/society_managment.dart';

class MaintenanceHistoryScreen extends StatelessWidget {
  const MaintenanceHistoryScreen({super.key});

  static const routeName = '/maintenance_history';

  static Widget builder(BuildContext context) {
    return BlocProvider<MaintenanceHistoryCubit>(
      create: (_) => MaintenanceHistoryCubit(),
      child: const MaintenanceHistoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.maintenance ?? '',
        color: AppColors.blue,
        centerTitle: false,
        systemUiStyle: SystemUiOverlayStyle.light,
        titleStyle: styleW600S24.copyWith(color: AppColors.white),
        backIconColor: AppColors.white,
      ),
      body: BlocBuilder<MaintenanceHistoryCubit, MaintenanceHistoryState>(
        builder: (context, state) {
          final cubit = context.read<MaintenanceHistoryCubit>();
          final items = cubit.filteredItems();

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppConstants.horizontalPadding,
                  20.h,
                  AppConstants.horizontalPadding,
                  0,
                ),
                child: AppSearchBar(
                  hintText: l10n?.visitorSearchHint ?? '',
                  onChanged: cubit.onSearchChanged,
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          l10n?.noResidentsAvailable ?? '',
                          style: styleW400S16.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(AppConstants.horizontalPadding),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.text.withValues(alpha: 0.05),
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          itemCount: items.length,
                          separatorBuilder: (_, _) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 3.h,
                            ),
                            child: CommonDivider(
                              color: AppColors.text.withValues(alpha: 0.1),
                            ),
                          ),
                          itemBuilder: (_, index) {
                            return _MaintenanceHistoryTile(
                              member: items[index],
                              l10n: l10n,
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MaintenanceHistoryTile extends StatelessWidget {
  const _MaintenanceHistoryTile({required this.member, required this.l10n});

  final MaintenanceMember member;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    final isCompleted = member.status == MaintenancePaymentStatus.completed;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        children: [
          ClipOval(
            child: AssetsImg(
              imagePath: AppAssets.defaultProfileImg,
              fit: BoxFit.cover,
              width: 48.w,
              height: 48.w,
            ),
          ),
          10.w.spaceHorizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${member.name} - ${member.flat}', style: styleW600S14),
                4.h.spaceVertical,
                Text(
                  '₹${member.amount}',
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          _MaintenanceStatusBadge(
            label: isCompleted
                ? (l10n?.completed ?? '')
                : (l10n?.pending ?? ''),
            isCompleted: isCompleted,
          ),
        ],
      ),
    );
  }
}

class _MaintenanceStatusBadge extends StatelessWidget {
  const _MaintenanceStatusBadge({
    required this.label,
    required this.isCompleted,
  });

  final String label;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final color = isCompleted ? AppColors.chartIncomeGreen : AppColors.primary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(label, style: styleW500S12.copyWith(color: color)),
    );
  }
}
