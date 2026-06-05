import 'package:society_managment/society_managment.dart';

class OverviewBody extends StatelessWidget {
  const OverviewBody({
    super.key,
    required this.state,
    required this.cubit,
    required this.l10n,
  });

  final MaintenanceState state;
  final MaintenanceCubit cubit;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    final months = cubit.monthLabels(l10n);

    return CustomSingleChildScroll(
      padding: EdgeInsets.fromLTRB(
        AppConstants.horizontalPadding,
        20.h,
        AppConstants.horizontalPadding,
        90.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NetBalanceCard(state: state, cubit: cubit, l10n: l10n),

          20.h.spaceVertical,

          AppSearchBar(
            hintText: l10n?.maintenanceSearchHint ?? '',
            onChanged: cubit.onSearchChanged,
          ),

          20.h.spaceVertical,

          CommonFilterChipRow(
            labels: months,
            selectedIndex: state.selectedMonthIndex,
            onSelected: cubit.onMonthSelected,
          ),

          16.h.spaceVertical,

          Text(l10n?.fundOverview ?? '', style: styleW600S18),

          12.h.spaceVertical,

          Column(
            spacing: 12.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: CommonOverviewCard(
                      imagePath: AppAssets.maintenanceImg,
                      value: '₹2,38,400',
                      title: l10n?.maintenanceCollected ?? '',
                      borderRadius: 12.r,
                    ),
                  ),
                  Expanded(
                    child: CommonOverviewCard(
                      imagePath: AppAssets.banquetHallImg,
                      value: '₹45,000',
                      title: l10n?.banquetHall ?? '',
                      borderRadius: 12.r,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: CommonOverviewCard(
                      imagePath: AppAssets.navratriImg,
                      value: '₹18,600',
                      title: l10n?.festivalFund ?? '',
                      borderRadius: 12.r,
                    ),
                  ),
                  Expanded(
                    child: CommonOverviewCard(
                      imagePath: AppAssets.moneyImg,
                      value: '₹80,000',
                      title: l10n?.otherIncome ?? '',
                      borderRadius: 12.r,
                    ),
                  ),
                ],
              ),
            ],
          ),

          20.h.spaceVertical,

          MonthlyTrendsChart(l10n: l10n),

          20.h.spaceVertical,

          OverviewHistorySections(
            l10n: l10n,
            transactions: cubit.overviewTransactions(),
            maintenanceItems: cubit.overviewMaintenanceItems(),
            onTransactionViewAll: () => context.navigator.pushNamed(
              TransactionHistoryScreen.routeName,
            ),
            onMaintenanceViewAll: () => context.navigator.pushNamed(
              MaintenanceHistoryScreen.routeName,
            ),
          ),
        ],
      ),
    );
  }
}

class _NetBalanceCard extends StatelessWidget {
  const _NetBalanceCard({
    required this.state,
    required this.cubit,
    required this.l10n,
  });

  final MaintenanceState state;
  final MaintenanceCubit cubit;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    const hiddenBalance = '₹ ••••••';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n?.netBalance ?? ''} - ${cubit.netBalancePeriodLabel(Localizations.localeOf(context).toString())}',
            style: styleW400S12.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
          ),

          2.h.spaceVertical,

          Row(
            children: [
              Expanded(
                child: Text(
                  state.isBalanceVisible
                      ? '₹ ${state.netBalance}'
                      : hiddenBalance,
                  style: styleW700S30.copyWith(color: AppColors.white),
                ),
              ),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: cubit.toggleBalanceVisibility,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: SvgAsset(
                      imagePath: AppAssets.eye,
                      height: 30.h,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          6.h.spaceVertical,

          Text(
            l10n?.vsLastMonth(state.balanceChange) ?? '',
            style: styleW400S14.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),

          14.h.spaceVertical,

          Row(
            children: [
              Expanded(
                child: _BalanceSubCard(
                  title: l10n?.totalIncome ?? '',
                  value: state.isBalanceVisible
                      ? '₹${state.totalIncome}'
                      : hiddenBalance,
                ),
              ),

              10.w.spaceHorizontal,

              Expanded(
                child: _BalanceSubCard(
                  title: l10n?.totalExpenses ?? '',
                  value: state.isBalanceVisible
                      ? '₹${state.totalExpenses}'
                      : hiddenBalance,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalanceSubCard extends StatelessWidget {
  const _BalanceSubCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: styleW400S12.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),

          4.h.spaceVertical,

          Text(value, style: styleW600S16.copyWith(color: AppColors.white)),
        ],
      ),
    );
  }
}
