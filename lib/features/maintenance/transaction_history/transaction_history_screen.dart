import 'package:society_managment/society_managment.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  static const routeName = '/transaction_history';

  static Widget builder(BuildContext context) {
    return BlocProvider<TransactionHistoryCubit>(
      create: (_) => TransactionHistoryCubit(),
      child: const TransactionHistoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.transactionHistory ?? '',
        color: AppColors.blue,
        centerTitle: false,
        systemUiStyle: SystemUiOverlayStyle.light,
        titleStyle: styleW600S24.copyWith(color: AppColors.white),
        backIconColor: AppColors.white,
      ),
      body: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
        builder: (context, state) {
          final cubit = context.read<TransactionHistoryCubit>();
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
                  hintText: l10n?.maintenanceSearchHint ?? '',
                  onChanged: cubit.onSearchChanged,
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          l10n?.noTransactionsAvailable ?? '',
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
                            return _TransactionHistoryTile(
                              transaction: items[index],
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

class _TransactionHistoryTile extends StatelessWidget {
  const _TransactionHistoryTile({required this.transaction, required this.l10n});

  final MaintenanceTransaction transaction;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isCredit
        ? AppColors.chartIncomeGreen
        : AppColors.logoutRed;

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
                Text(
                  '${transaction.name} - ${transaction.flat}',
                  style: styleW600S14,
                ),
                4.h.spaceVertical,
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
              4.h.spaceVertical,
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
