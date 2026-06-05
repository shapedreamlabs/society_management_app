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
                child: Text(
                  l10n?.visitor ?? '',
                  style: styleW700S24.copyWith(color: AppColors.white),
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
                      20.h.spaceVertical,
                      AppSearchBar(
                        hintText: l10n?.visitorSearchHint ?? '',
                        onChanged: cubit.onSearchChanged,
                      ),
                      16.h.spaceVertical,
                      Text(l10n?.todayVisitor ?? '', style: styleW500S20),
                      12.h.spaceVertical,
                      _VisitorSectionCard(visitors: todayVisitors, l10n: l10n),
                      20.h.spaceVertical,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n?.otherVisitor ?? '', style: styleW500S20),
                          Text(
                            l10n?.viewAll ?? '',
                            style: styleW400S16.copyWith(
                              color: AppColors.text.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                      12.h.spaceVertical,
                      _VisitorSectionCard(visitors: otherVisitors, l10n: l10n),
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
  const _VisitorSectionCard({required this.visitors, required this.l10n});

  final List<Map<String, String>> visitors;
  final AppLocalizations? l10n;

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

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: .zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: visitors.length,
        separatorBuilder: (_, _) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: CommonDivider(color: AppColors.text.withValues(alpha: 0.08)),
        ),
        itemBuilder: (_, index) {
          final visitor = visitors[index];
          return _VisitorRow(
            name: visitor['name'] ?? '',
            meta: visitor['meta'] ?? '',
            status: visitor['status'] ?? '',
            approvedLabel: l10n?.approved ?? '',
            rejectedLabel: l10n?.rejected ?? '',
          );
        },
      ),
    );
  }
}

class _VisitorRow extends StatelessWidget {
  const _VisitorRow({
    required this.name,
    required this.meta,
    required this.status,
    required this.approvedLabel,
    required this.rejectedLabel,
  });

  final String name;
  final String meta;
  final String status;
  final String approvedLabel;
  final String rejectedLabel;

  @override
  Widget build(BuildContext context) {
    final isApproved = status == 'approved';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          ClipOval(
            child: AssetsImg(
              imagePath: AppAssets.defaultProfileImg,
              fit: BoxFit.cover,
              width: 40.w,
              height: 40.w,
            ),
          ),
          10.w.spaceHorizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: styleW600S16),
                2.h.spaceVertical,
                Text(
                  meta,
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: (isApproved ? AppColors.orange : AppColors.red).withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              isApproved ? approvedLabel : rejectedLabel,
              style: styleW500S12.copyWith(
                color: isApproved ? AppColors.orange : AppColors.darkRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
