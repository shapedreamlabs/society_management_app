import 'package:society_managment/society_management.dart';

class AddComplainScreen extends StatelessWidget {
  const AddComplainScreen({super.key});

  static const routeName = '/add_complain';

  static Widget builder(BuildContext context) {
    return BlocProvider<AddComplainCubit>(
      create: (_) => AddComplainCubit(),
      child: const AddComplainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.addComplain ?? "",
        centerTitle: true,
        color: AppColors.bgColor,
        titleStyle: styleW500S24,
        backIconColor: AppColors.text,
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(
          AppConstants.horizontalPadding,
          0,
          AppConstants.horizontalPadding,
          12.h,
        ),
        child: CustomButton(title: l10n?.submitComplaint ?? "", onTap: () {}),
      ),
      body: BlocBuilder<AddComplainCubit, AddComplainState>(
        builder: (context, state) {
          final cubit = context.read<AddComplainCubit>();

          return CustomSingleChildScroll(
            padding: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              12.h,
              AppConstants.horizontalPadding,
              16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  header: l10n?.name ?? "",
                  hintText: l10n?.enterName ?? "",
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.flatNoLocation ?? "",
                  hintText: l10n?.enterFlatNoLocation ?? "",
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.complaintTitle ?? "",
                  hintText: l10n?.enterComplaintTitle ?? "",
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.date ?? "",
                  hintText: state.date.isEmpty
                      ? (l10n?.selectDate ?? "")
                      : state.date,
                  suffixIcon: AppAssets.calender,
                  readOnly: true,
                  onTap: () => cubit.pickDate(context),
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.priority ?? "",
                  hintText: l10n?.selectPriority ?? "",
                  items: cubit.priorities,
                  value: state.priority,
                  itemAsString: (value) => LocalizationLabels.of(l10n, value),
                  onChanged: cubit.onPriorityChanged,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
