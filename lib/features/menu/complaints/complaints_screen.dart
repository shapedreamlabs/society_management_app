import 'package:society_managment/society_managment.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  static const routeName = '/complaints';

  static Widget builder(BuildContext context) {
    return BlocProvider<ComplaintsCubit>(
      create: (_) => ComplaintsCubit(),
      child: const ComplaintsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      floatingActionButton: CommonFloatingActionButton(
        onPressed: () =>
            context.read<ComplaintsCubit>().onAddComplainTap(context),
        child: SvgAsset(
          imagePath: AppAssets.add,
          height: 24.h,
          color: AppColors.white,
        ),
      ),
      appBar: CustomAppBar(
        title: l10n?.complaints ?? "",
        centerTitle: false,
        color: AppColors.blue,
        systemUiStyle: SystemUiOverlayStyle.light,
        titleStyle: styleW600S24.copyWith(color: AppColors.white),
        backIconColor: AppColors.white,
      ),
      body: BlocBuilder<ComplaintsCubit, ComplaintsState>(
        builder: (context, state) {
          final cubit = context.read<ComplaintsCubit>();
          final items = cubit.filteredItems();

          return Column(
            children: [
              _FilterChipsRow(
                filter: state.filter,
                urgentCount: cubit.allItems
                    .where((e) => e['status'] == 'urgent')
                    .length,
                normalCount: cubit.allItems
                    .where((e) => e['status'] == 'normal')
                    .length,
                resolvedCount: cubit.allItems
                    .where((e) => e['status'] == 'resolved')
                    .length,
                onChanged: cubit.onFilterChanged,
                l10n: l10n,
              ),
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          l10n?.noComplaintsAvailable ?? "",
                          style: styleW400S16.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          AppConstants.horizontalPadding,
                          12.h,
                          AppConstants.horizontalPadding,
                          80.h,
                        ),
                        itemCount: items.length,
                        separatorBuilder: (_, _) => 12.h.spaceVertical,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _ComplaintCard(
                            title: item['title'] ?? '',
                            meta: item['meta'] ?? '',
                            status: item['status'] ?? '',
                            urgentLabel: l10n?.urgent ?? "",
                            normalLabel: l10n?.normal ?? "",
                            resolvedLabel: l10n?.resolved ?? "",
                            assignToStaffLabel: l10n?.assignToStaff ?? "",
                            assignLabel: l10n?.assign ?? "",
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

class _FilterChipsRow extends StatelessWidget {
  const _FilterChipsRow({
    required this.filter,
    required this.urgentCount,
    required this.normalCount,
    required this.resolvedCount,
    required this.onChanged,
    required this.l10n,
  });

  final ComplaintsFilter filter;
  final int urgentCount;
  final int normalCount;
  final int resolvedCount;
  final void Function(ComplaintsFilter value) onChanged;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppConstants.horizontalPadding,
        14.h,
        AppConstants.horizontalPadding,
        0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _FilterChip(
              label:
                  '${l10n?.all ?? ""} (${urgentCount + normalCount + resolvedCount})',
              isSelected: filter == ComplaintsFilter.all,
              onTap: () => onChanged(ComplaintsFilter.all),
            ),
            10.w.spaceHorizontal,
            _FilterChip(
              label: '${l10n?.urgent ?? ""} ($urgentCount)',
              isSelected: filter == ComplaintsFilter.urgent,
              onTap: () => onChanged(ComplaintsFilter.urgent),
            ),
            10.w.spaceHorizontal,
            _FilterChip(
              label: '${l10n?.normal ?? ""} ($normalCount)',
              isSelected: filter == ComplaintsFilter.normal,
              onTap: () => onChanged(ComplaintsFilter.normal),
            ),
            10.w.spaceHorizontal,
            _FilterChip(
              label: l10n?.resolved ?? "",
              isSelected: filter == ComplaintsFilter.resolved,
              onTap: () => onChanged(ComplaintsFilter.resolved),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.orange : AppColors.white,
      borderRadius: BorderRadius.circular(24.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Text(
            label,
            style: styleW500S12.copyWith(
              color: isSelected ? AppColors.white : AppColors.text,
            ),
          ),
        ),
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  const _ComplaintCard({
    required this.title,
    required this.meta,
    required this.status,
    required this.urgentLabel,
    required this.normalLabel,
    required this.resolvedLabel,
    required this.assignToStaffLabel,
    required this.assignLabel,
  });

  final String title;
  final String meta;
  final String status;
  final String urgentLabel;
  final String normalLabel;
  final String resolvedLabel;
  final String assignToStaffLabel;
  final String assignLabel;

  bool get _isUrgent => status == 'urgent';

  bool get _isNormal => status == 'normal';

  bool get _isResolved => status == 'resolved';

  @override
  Widget build(BuildContext context) {
    final badgeText = _isUrgent
        ? urgentLabel
        : (_isNormal ? normalLabel : resolvedLabel);
    final badgeColor = _isResolved
        ? AppColors.orange
        : (_isNormal ? AppColors.goldenYellow : AppColors.red);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: styleW600S16)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  badgeText,
                  style: styleW500S12.copyWith(
                    color: _isResolved
                        ? AppColors.orange
                        : (_isNormal
                              ? AppColors.text.withValues(alpha: 0.7)
                              : AppColors.darkRed),
                  ),
                ),
              ),
            ],
          ),
          6.h.spaceVertical,
          Text(
            meta,
            style: styleW400S14.copyWith(
              color: AppColors.text.withValues(alpha: 0.6),
            ),
          ),
          12.h.spaceVertical,
          if (!_isResolved)
            CustomButton(
              title: assignToStaffLabel,
              onTap: () {},
              height: 42.h,
              borderRadius: 8.r,
            )
          else
            Container(
              height: 42.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.orange),
              ),
              child: Text(
                assignLabel,
                style: styleW700S14.copyWith(color: AppColors.orange),
              ),
            ),
        ],
      ),
    );
  }
}
