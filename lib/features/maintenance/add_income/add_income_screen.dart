import 'package:society_managment/society_managment.dart';

class AddIncomeScreen extends StatelessWidget {
  const AddIncomeScreen({super.key});

  static const routeName = '/add_income';

  static Widget builder(BuildContext context) {
    return BlocProvider<AddIncomeCubit>(
      create: (_) => AddIncomeCubit(),
      child: const AddIncomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<AddIncomeCubit, AddIncomeState>(
      builder: (context, state) {
        final cubit = context.read<AddIncomeCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.addIncome ?? '',
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
              title: l10n?.addIncome ?? '',
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
                AppTextField(
                  controller: cubit.titleController,
                  header: l10n?.incomeTitle ?? '',
                  hintText: l10n?.enterIncomeTitle ?? '',
                  error: state.titleError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  controller: cubit.amountController,
                  header: l10n?.amount ?? '',
                  hintText: l10n?.enterAmount ?? '',
                  textInputType: TextInputType.number,
                  error: state.amountError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.category ?? '',
                  hintText: l10n?.selectCategory ?? '',
                  items: cubit.categories,
                  value: state.category,
                  itemAsString: (value) => value,
                  onChanged: cubit.onCategoryChanged,
                  error: state.categoryError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.receivedFrom ?? '',
                  hintText: l10n?.selectPerson ?? '',
                  items: cubit.persons,
                  value: state.receivedFrom,
                  itemAsString: (value) => value,
                  onChanged: cubit.onReceivedFromChanged,
                  error: state.receivedFromError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.paymentMethod ?? '',
                  hintText: l10n?.selectPaymentMethod ?? '',
                  items: cubit.paymentMethods,
                  value: state.paymentMethod,
                  itemAsString: (value) => value,
                  onChanged: cubit.onPaymentMethodChanged,
                  error: state.paymentMethodError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.date ?? '',
                  hintText: state.date.isEmpty
                      ? (l10n?.selectDate ?? '')
                      : state.date,
                  suffixIcon: AppAssets.calender,
                  readOnly: true,
                  onTap: () => cubit.pickDate(context),
                  error: state.dateError,
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
