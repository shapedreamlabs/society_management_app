import 'package:society_managment/society_managment.dart';

class ExpensesBody extends StatelessWidget {
  const ExpensesBody({super.key, required this.l10n});

  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceCubit, MaintenanceState>(
      builder: (context, state) {
        return CustomSingleChildScroll(
          padding: EdgeInsets.fromLTRB(
            AppConstants.horizontalPadding,
            16.h,
            AppConstants.horizontalPadding,
            90.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSearchBar(
                hintText: l10n?.maintenanceSearchHint ?? '',
                onChanged: context.read<MaintenanceCubit>().onSearchChanged,
              ),
              20.h.spaceVertical,
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Text(
                    l10n?.noTransactionsAvailable ?? '',
                    style: styleW400S16.copyWith(
                      color: AppColors.text.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
