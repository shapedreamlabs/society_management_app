import 'package:society_managment/society_managment.dart';

class OverviewHistorySections extends StatelessWidget {
  const OverviewHistorySections({
    super.key,
    required this.l10n,
    required this.transactions,
    required this.maintenanceItems,
  });

  final AppLocalizations? l10n;
  final List<MaintenanceTransaction> transactions;
  final List<MaintenanceMember> maintenanceItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: l10n?.transactionHistory ?? '',
          actionLabel: l10n?.viewAll ?? '',
        ),
        12.h.spaceVertical,
        _OverviewListCard(
          child: transactions.isEmpty
              ? _EmptyMessage(message: l10n?.noTransactionsAvailable ?? '')
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  itemCount: transactions.length,
                  separatorBuilder: (_, _) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CommonDivider(
                      color: AppColors.text.withValues(alpha: 0.08),
                    ),
                  ),
                  itemBuilder: (_, index) {
                    return _TransactionHistoryTile(
                      transaction: transactions[index],
                    );
                  },
                ),
        ),
        20.h.spaceVertical,
        _SectionHeader(
          title: l10n?.maintenance ?? '',
          actionLabel: l10n?.viewAll ?? '',
        ),
        12.h.spaceVertical,
        _OverviewListCard(
          child: maintenanceItems.isEmpty
              ? _EmptyMessage(message: l10n?.noTransactionsAvailable ?? '')
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  itemCount: maintenanceItems.length,
                  separatorBuilder: (_, _) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CommonDivider(
                      color: AppColors.text.withValues(alpha: 0.08),
                    ),
                  ),
                  itemBuilder: (_, index) {
                    return _OverviewMaintenanceTile(
                      member: maintenanceItems[index],
                      l10n: l10n,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.actionLabel});

  final String title;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: styleW600S18),
        Text(
          actionLabel,
          style: styleW400S16.copyWith(
            color: AppColors.text.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _OverviewListCard extends StatelessWidget {
  const _OverviewListCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  const _EmptyMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28.h),
      child: Center(
        child: Text(
          message,
          style: styleW400S16.copyWith(
            color: AppColors.text.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}

class _TransactionHistoryTile extends StatelessWidget {
  const _TransactionHistoryTile({required this.transaction});

  final MaintenanceTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isCredit
        ? AppColors.chartIncomeGreen
        : AppColors.logoutRed;

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
                Text(
                  '${transaction.name} - ${transaction.flat}',
                  style: styleW600S14,
                ),
                2.h.spaceVertical,
                Text(
                  transaction.category,
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.amount,
                style: styleW600S14.copyWith(color: amountColor),
              ),
              2.h.spaceVertical,
              Text(
                transaction.date,
                style: styleW400S12.copyWith(
                  color: AppColors.text.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewMaintenanceTile extends StatelessWidget {
  const _OverviewMaintenanceTile({required this.member, required this.l10n});

  final MaintenanceMember member;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    final isCompleted = member.status == MaintenancePaymentStatus.completed;

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
          _OverviewStatusBadge(
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

class _OverviewStatusBadge extends StatelessWidget {
  const _OverviewStatusBadge({required this.label, required this.isCompleted});

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
