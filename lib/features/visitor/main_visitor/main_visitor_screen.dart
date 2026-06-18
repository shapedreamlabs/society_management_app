import 'package:society_managment/society_managment.dart';

class MainVisitorScreen extends StatelessWidget {
  const MainVisitorScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MainVisitorCubit>(
      create: (_) => MainVisitorCubit(),
      child: const MainVisitorScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      floatingActionButton: CommonFloatingActionButton(
        onPressed: () =>
            context.navigator.pushNamed(GuardAddVisitorScreen.routeName),
        child: SvgAsset(
          imagePath: AppAssets.add,
          height: 24.h,
          color: AppColors.white,
        ),
      ),
      body: BlocBuilder<MainVisitorCubit, MainVisitorState>(
        builder: (context, state) {
          final cubit = context.read<MainVisitorCubit>();
          final todayVisitors = cubit.filteredTodayVisitors();
          final otherVisitors = cubit.filteredOtherVisitors();

          return Column(
            children: [
              Container(
                width: double.infinity,
                color: AppColors.blue,
                padding: EdgeInsets.fromLTRB(
                  AppConstants.horizontalPadding,
                  MediaQuery.of(context).padding.top + 14.h,
                  AppConstants.horizontalPadding,
                  14.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n?.visitor ?? '',
                        style: styleW700S24.copyWith(color: AppColors.white),
                      ),
                    ),
                    CustomIconButton(
                      icon: AppAssets.history,
                      size: 22.h,
                      padding: 8.w,
                      onTap: () => context.navigator.pushNamed(
                        VisitorHistoryScreen.routeName,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomSingleChildScroll(
                  padding: EdgeInsets.fromLTRB(
                    AppConstants.horizontalPadding,
                    20.h,
                    AppConstants.horizontalPadding,
                    14.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonFilterChipRow(
                        labels: [
                          l10n?.allWing ?? '',
                          l10n?.wingA ?? '',
                          l10n?.wingB ?? '',
                          l10n?.wingC ?? '',
                        ],
                        selectedIndex: state.filter.index,
                        onSelected: (index) => cubit.onFilterChanged(
                          MainVisitorFilter.values[index],
                        ),
                      ),

                      // Space
                      20.h.spaceVertical,

                      AppSearchBar(
                        hintText: l10n?.visitorSearchHint ?? '',
                        onChanged: cubit.onSearchChanged,
                      ),

                      // Space
                      16.h.spaceVertical,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n?.todayVisitor ?? '', style: styleW500S20),
                          GestureDetector(
                            onTap: () => context.navigator.pushNamed(
                              VisitorHistoryScreen.routeName,
                            ),
                            child: Text(
                              l10n?.viewAll ?? '',
                              style: styleW400S16.copyWith(
                                color: AppColors.text.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Space
                      12.h.spaceVertical,

                      _VisitorSectionCard(
                        visitors: todayVisitors,
                        l10n: l10n,
                        cubit: cubit,
                        isTodaySection: true,
                      ),

                      // Space
                      20.h.spaceVertical,

                      Text(
                        l10n?.upcomingVisitorBooking ?? '',
                        style: styleW500S20,
                      ),

                      // Space
                      12.h.spaceVertical,

                      _VisitorSectionCard(
                        visitors: otherVisitors,
                        l10n: l10n,
                        cubit: cubit,
                        isTodaySection: false,
                        isUpcomingSection: true,
                      ),
                    ],
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

class _VisitorSectionCard extends StatelessWidget {
  const _VisitorSectionCard({
    required this.visitors,
    required this.l10n,
    required this.cubit,
    required this.isTodaySection,
    this.isUpcomingSection = false,
  });

  final List<Map<String, String>> visitors;
  final AppLocalizations? l10n;
  final MainVisitorCubit cubit;
  final bool isTodaySection;
  final bool isUpcomingSection;

  @override
  Widget build(BuildContext context) {
    if (visitors.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 28.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            l10n?.noVisitorsAvailable ?? '',
            style: styleW400S16.copyWith(
              color: AppColors.text.withValues(alpha: 0.6),
            ),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(visitors.length, (index) {
        final visitor = visitors[index];

        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 12.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
              status: isUpcomingSection ? 'booked' : (visitor['status'] ?? ''),
              approvedLabel: l10n?.approved ?? '',
              rejectedLabel: l10n?.rejected ?? '',
              calledLabel: l10n?.called ?? '',
              bookedLabel: l10n?.booked ?? '',
              vehicleNoLabel: l10n?.vehicleNo ?? '',
              checkInLabel: l10n?.checkIn ?? '',
              checkOutLabel: l10n?.checkOut ?? '',
              showTimeSection: !isUpcomingSection,
              showCheckOutAction: isTodaySection,
              onCheckOutTap: isTodaySection
                  ? () => cubit.onVisitorCheckOut(
                      visitor['id'] ?? '',
                      isTodaySection: isTodaySection,
                    )
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
