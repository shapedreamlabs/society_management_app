import 'package:society_managment/society_management.dart';

class VisitorHistoryScreen extends StatelessWidget {
  const VisitorHistoryScreen({super.key});

  static const routeName = '/visitor_history';

  static Widget builder(BuildContext context) {
    return BlocProvider<VisitorHistoryCubit>(
      create: (_) => VisitorHistoryCubit(),
      child: const VisitorHistoryScreen(),
    );
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    final cubit = context.read<VisitorHistoryCubit>();
    final l10n = context.l10n;
    final state = cubit.state;

    final result = await AppBottomSheet.show<VisitorHistoryFilterResult>(
      context: context,
      title: l10n?.filter,
      child: VisitorHistoryFilterSheet(
        initialDateFilter: state.dateFilter,
        initialStatusFilter: state.statusFilter,
        initialWingFilter: state.wingFilter,
      ),
    );

    if (result != null) {
      cubit.applyFilters(
        dateFilter: result.dateFilter,
        statusFilter: result.statusFilter,
        wingFilter: result.wingFilter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.visitorHistory ?? '',
        color: AppColors.blue,
        centerTitle: false,
        systemUiStyle: SystemUiOverlayStyle.light,
        titleStyle: styleW600S24.copyWith(color: AppColors.white),
        backIconColor: AppColors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppConstants.horizontalPadding),
            child: CustomIconButton(
              icon: AppAssets.filter,
              size: 22.h,
              padding: 8.w,
              onTap: () => _openFilterSheet(context),
            ),
          ),
        ],
      ),
      body: BlocBuilder<VisitorHistoryCubit, VisitorHistoryState>(
        builder: (context, state) {
          final cubit = context.read<VisitorHistoryCubit>();
          final visitors = cubit.filteredVisitors();
          const wingChipFilters = [
            VisitorHistoryWingFilter.all,
            VisitorHistoryWingFilter.wingA,
            VisitorHistoryWingFilter.wingB,
            VisitorHistoryWingFilter.wingC,
          ];

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppConstants.horizontalPadding,
                  14.h,
                  AppConstants.horizontalPadding,
                  0,
                ),
                child: CommonFilterChipRow(
                  labels: [
                    l10n?.allWing ?? '',
                    l10n?.wingA ?? '',
                    l10n?.wingB ?? '',
                    l10n?.wingC ?? '',
                  ],
                  selectedIndex: state.wingChipSelectedIndex,
                  onSelected: (index) => cubit.onWingChipChanged(
                    wingChipFilters[index],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppConstants.horizontalPadding,
                  14.h,
                  AppConstants.horizontalPadding,
                  0,
                ),
                child: AppSearchBar(
                  hintText: l10n?.visitorSearchHint ?? '',
                  onChanged: cubit.onSearchChanged,
                ),
              ),

              Expanded(
                child: visitors.isEmpty
                    ? Center(
                        child: Text(
                          l10n?.noVisitorsAvailable ?? '',
                          style: styleW400S16.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          AppConstants.horizontalPadding,
                          16.h,
                          AppConstants.horizontalPadding,
                          20.h,
                        ),
                        itemCount: visitors.length,
                        separatorBuilder: (_, _) => 12.h.spaceVertical,
                        itemBuilder: (_, index) {
                          final visitor = visitors[index];

                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: AppColors.text.withValues(alpha: 0.05),
                              ),
                            ),
                            child: VisitorCard(
                              name: visitor['name'] ?? '',
                              flat: visitor['flat'] ?? '',
                              date: visitor['date'] ?? '',
                              vehicleNo: visitor['vehicle_no'] ?? '',
                              checkIn: visitor['check_in'] ?? '',
                              checkOut: visitor['check_out'] ?? '',
                              status: visitor['status'] ?? '',
                              approvedLabel: l10n?.approved ?? '',
                              rejectedLabel: l10n?.rejected ?? '',
                              calledLabel: l10n?.called ?? '',
                              vehicleNoLabel: l10n?.vehicleNo ?? '',
                              checkInLabel: l10n?.checkIn ?? '',
                              checkOutLabel: l10n?.checkOut ?? '',
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
