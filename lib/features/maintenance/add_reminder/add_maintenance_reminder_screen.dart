import 'package:society_managment/society_management.dart';

class AddMaintenanceReminderScreen extends StatelessWidget {
  const AddMaintenanceReminderScreen({super.key});

  static const routeName = '/add_maintenance_reminder';

  static Widget builder(BuildContext context) {
    return BlocProvider<AddMaintenanceReminderCubit>(
      create: (_) => AddMaintenanceReminderCubit(),
      child: const AddMaintenanceReminderScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<
      AddMaintenanceReminderCubit,
      AddMaintenanceReminderState
    >(
      builder: (context, state) {
        final cubit = context.read<AddMaintenanceReminderCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.addMaintenanceReminder ?? '',
            centerTitle: true,
            color: AppColors.bgColor,
            titleStyle: styleW600S24,
            backIconColor: AppColors.text,
          ),
          bottomNavigationBar: SafeArea(
            minimum: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              0,
              AppConstants.horizontalPadding,
              12.h,
            ),
            child: CustomButton(
              title: l10n?.generateMaintenance ?? '',
              isLoading: state.loader,
              onTap: () => cubit.onSubmit(context),
            ),
          ),
          body: CustomSingleChildScroll(
            padding: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              12.h,
              AppConstants.horizontalPadding,
              16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppDropDown<String>(
                  header: l10n?.wing ?? '',
                  hintText: l10n?.selectWing ?? '',
                  items: cubit.wings,
                  value: state.wing,
                  itemAsString: (value) => cubit.wingLabel(context, value),
                  onChanged: cubit.onWingChanged,
                  error: state.wingError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.flat ?? '',
                  hintText: l10n?.selectFlat ?? '',
                  items: cubit.flats,
                  value: state.flat,
                  itemAsString: (value) => value,
                  onChanged: cubit.onFlatChanged,
                  error: state.flatError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  controller: cubit.amountController,
                  header: l10n?.maintenanceAmount ?? '',
                  hintText: l10n?.enterMaintenanceAmount ?? '',
                  textInputType: TextInputType.number,
                  error: state.amountError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.billingMonth ?? '',
                  hintText: state.billingMonth.isEmpty
                      ? (l10n?.selectDate ?? '')
                      : state.billingMonth,
                  suffixIcon: AppAssets.calender,
                  readOnly: true,
                  onTap: () => cubit.pickBillingMonth(context),
                  error: state.billingMonthError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  controller: cubit.notesController,
                  header: l10n?.notes ?? '',
                  hintText: l10n?.typeHere ?? '',
                  maxLines: 4,
                  minLines: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
