import 'package:society_managment/society_management.dart';

class MaintenanceTabBody extends StatelessWidget {
  const MaintenanceTabBody({super.key, required this.l10n});

  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceCubit, MaintenanceState>(
      builder: (context, state) {
        final cubit = context.read<MaintenanceCubit>();
        final members = cubit.maintenanceMembers();

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
              _NetMaintenanceCard(state: state, cubit: cubit, l10n: l10n),

              20.h.spaceVertical,

              Row(
                children: [
                  Expanded(
                    child: Text(l10n?.memberList ?? '', style: styleW600S18),
                  ),
                  GestureDetector(
                    onTap: state.isMemberEditMode
                        ? cubit.toggleSelectAllMembers
                        : cubit.enterMemberEditMode,
                    child: Text(
                      state.isMemberEditMode
                          ? (l10n?.selectAll ?? '')
                          : (l10n?.edit ?? ''),
                      style: styleW500S14,
                    ),
                  ),
                ],
              ),

              16.h.spaceVertical,

              if (members.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      l10n?.noResidentsAvailable ?? '',
                      style: styleW400S16.copyWith(
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                )
              else
                _MemberListCard(
                  members: members,
                  l10n: l10n,
                  showCheckbox: state.isMemberEditMode,
                  onCheckboxTap: cubit.toggleMemberSelected,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _MemberListCard extends StatelessWidget {
  const _MemberListCard({
    required this.members,
    required this.l10n,
    required this.showCheckbox,
    required this.onCheckboxTap,
  });

  final List<MaintenanceMember> members;
  final AppLocalizations? l10n;
  final bool showCheckbox;
  final void Function(String id) onCheckboxTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: members.length,
        separatorBuilder: (_, _) => Divider(
          height: 1,
          thickness: 1,
          color: AppColors.text.withValues(alpha: 0.06),
          indent: 14.w,
          endIndent: 14.w,
        ),
        itemBuilder: (_, index) {
          final member = members[index];

          return _MaintenanceMemberTile(
            member: member,
            l10n: l10n,
            showCheckbox: showCheckbox,
            onCheckboxTap: () => onCheckboxTap(member.id),
          );
        },
      ),
    );
  }
}

class _NetMaintenanceCard extends StatelessWidget {
  const _NetMaintenanceCard({
    required this.state,
    required this.cubit,
    required this.l10n,
  });

  final MaintenanceState state;
  final MaintenanceCubit cubit;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    const hiddenAmount = '₹ ••••••';

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
            '${l10n?.netMaintenance ?? ''} - ${cubit.netBalancePeriodLabel(Localizations.localeOf(context).toString())}',
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
                  state.isMaintenanceVisible
                      ? '₹ ${state.netMaintenance}'
                      : hiddenAmount,
                  style: styleW700S30.copyWith(color: AppColors.white),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: cubit.toggleMaintenanceVisibility,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: SvgAsset(
                      imagePath: state.isMaintenanceVisible
                          ? AppAssets.eye
                          : AppAssets.eyeClose,
                      height: 30.h,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          14.h.spaceVertical,

          Row(
            children: [
              Expanded(
                child: _MaintenanceSubCard(
                  title: l10n?.pendingMaintenance ?? '',
                  value: state.isMaintenanceVisible
                      ? '₹${state.pendingMaintenance}'
                      : hiddenAmount,
                ),
              ),
              10.w.spaceHorizontal,
              Expanded(
                child: _MaintenanceSubCard(
                  title: l10n?.expectedMaintenance ?? '',
                  value: state.isMaintenanceVisible
                      ? '₹${state.expectedMaintenance}'
                      : hiddenAmount,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MaintenanceSubCard extends StatelessWidget {
  const _MaintenanceSubCard({required this.title, required this.value});

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

class _MaintenanceMemberTile extends StatelessWidget {
  const _MaintenanceMemberTile({
    required this.member,
    required this.l10n,
    required this.showCheckbox,
    required this.onCheckboxTap,
  });

  final MaintenanceMember member;
  final AppLocalizations? l10n;
  final bool showCheckbox;
  final VoidCallback onCheckboxTap;

  @override
  Widget build(BuildContext context) {
    final isCompleted = member.status == MaintenancePaymentStatus.completed;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
      child: Row(
        children: [
          if (showCheckbox) ...[
            _MemberCheckbox(value: member.isSelected, onTap: onCheckboxTap),
            10.w.spaceHorizontal,
          ],
          ClipOval(
            child: AssetsImg(
              imagePath: AppAssets.defaultProfileImg,
              fit: BoxFit.cover,
              width: 44.w,
              height: 44.w,
            ),
          ),
          10.w.spaceHorizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${member.name} - ${member.flat}', style: styleW600S14),
                2.h.spaceVertical,
                Text(
                  '₹${member.amount}',
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          8.w.spaceHorizontal,
          _PaymentStatusBadge(
            label: isCompleted ? (l10n?.completed ?? '') : (l10n?.pending ?? ''),
            isCompleted: isCompleted,
          ),
        ],
      ),
    );
  }
}

class _MemberCheckbox extends StatelessWidget {
  const _MemberCheckbox({required this.value, required this.onTap});

  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 22.w,
        height: 22.w,
        decoration: BoxDecoration(
          color: value ? AppColors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: value
                ? AppColors.orange
                : AppColors.text.withValues(alpha: 0.25),
          ),
        ),
        alignment: Alignment.center,
        child: value
            ? SvgAsset(
                imagePath: AppAssets.tick,
                height: 14.h,
                color: AppColors.white,
              )
            : null,
      ),
    );
  }
}

class _PaymentStatusBadge extends StatelessWidget {
  const _PaymentStatusBadge({required this.label, required this.isCompleted});

  final String label;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final color = isCompleted
        ? AppColors.chartIncomeGreen
        : AppColors.logoutRed;

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
