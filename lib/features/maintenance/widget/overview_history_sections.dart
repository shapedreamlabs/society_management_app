import 'package:society_managment/society_management.dart';

class OverviewHistorySections extends StatelessWidget {
  const OverviewHistorySections({
    super.key,
    required this.l10n,
    required this.transactions,
    required this.maintenanceItems,
    this.onTransactionViewAll,
    this.onMaintenanceViewAll,
  });

  final AppLocalizations? l10n;
  final List<MaintenanceTransaction> transactions;
  final List<MaintenanceMember> maintenanceItems;
  final VoidCallback? onTransactionViewAll;
  final VoidCallback? onMaintenanceViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerRow(
          title: l10n?.transactionHistory ?? '',
          actionLabel: l10n?.viewAll ?? '',
          onActionTap: onTransactionViewAll,
        ),

        // Space
        12.h.spaceVertical,

        overViewListCard(
          child: transactions.isEmpty
              ? emptyMessage(message: l10n?.noTransactionsAvailable ?? '')
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
                      l10n: l10n,
                    );
                  },
                ),
        ),

        // Space
        20.h.spaceVertical,

        headerRow(
          title: l10n?.maintenance ?? '',
          actionLabel: l10n?.viewAll ?? '',
          onActionTap: onMaintenanceViewAll,
        ),

        // Space
        12.h.spaceVertical,

        overViewListCard(
          child: maintenanceItems.isEmpty
              ? emptyMessage(message: l10n?.noTransactionsAvailable ?? '')
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

  Widget headerRow({
    required String title,
    required String actionLabel,
    VoidCallback? onActionTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: styleW600S18),

        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionLabel,
            style: styleW400S16.copyWith(
              color: AppColors.text.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget overViewListCard({required Widget child}) {
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

  Widget emptyMessage({required String message}) {
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
  const _TransactionHistoryTile({
    required this.transaction,
    required this.l10n,
  });

  final MaintenanceTransaction transaction;
  final AppLocalizations? l10n;

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

                // Space
                2.h.spaceVertical,

                Text(
                  LocalizationLabels.of(l10n, transaction.category),
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

              // Space
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

          // Space
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
    final color = isCompleted
        ? AppColors.chartIncomeGreen
        : AppColors.chartExpenseRed;

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
