import 'package:society_managment/society_managment.dart';

class BookBanquetHallScreen extends StatelessWidget {
  const BookBanquetHallScreen({super.key});

  static const routeName = '/book_banquet_hall';

  static Widget builder(BuildContext context) {
    return BlocProvider<BookBanquetHallCubit>(
      create: (_) => BookBanquetHallCubit(),
      child: const BookBanquetHallScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.bookBanquetHall ?? "",
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
        child: CustomButton(
          title: l10n?.bookNow ?? "",
          onTap: () {
            context.read<BookBanquetHallCubit>().onBookNow(
              context,
              context.l10n,
            );
          },
        ),
      ),
      body: BlocBuilder<BookBanquetHallCubit, BookBanquetHallState>(
        builder: (context, state) {
          final cubit = context.read<BookBanquetHallCubit>();

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
                  onChanged: cubit.onNameChanged,
                  error: state.nameError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.contactNumber ?? "",
                  hintText: l10n?.enterContactNumber ?? "",
                  textInputType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: cubit.onContactNumberChanged,
                  error: state.contactNumberError,
                ),
                14.h.spaceVertical,
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        header: l10n?.startDate ?? "",
                        hintText: state.startDate.isEmpty
                            ? (l10n?.selectDate ?? "")
                            : state.startDate,
                        suffixIcon: AppAssets.calender,
                        readOnly: true,
                        onTap: () => cubit.pickStartDate(context),
                        error: state.startDateError,
                      ),
                    ),
                    12.w.spaceHorizontal,
                    Expanded(
                      child: AppTextField(
                        header: l10n?.endDate ?? "",
                        hintText: state.endDate.isEmpty
                            ? (l10n?.selectDate ?? "")
                            : state.endDate,
                        suffixIcon: AppAssets.calender,
                        readOnly: true,
                        onTap: () => cubit.pickEndDate(context),
                        error: state.endDateError,
                      ),
                    ),
                  ],
                ),
                14.h.spaceVertical,
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        header: l10n?.startTime ?? "",
                        hintText: state.startTime.isEmpty
                            ? (l10n?.selectTime ?? "")
                            : state.startTime,
                        suffixIcon: AppAssets.clock,
                        readOnly: true,
                        onTap: () => cubit.pickStartTime(context),
                        error: state.startTimeError,
                      ),
                    ),
                    12.w.spaceHorizontal,
                    Expanded(
                      child: AppTextField(
                        header: l10n?.endTime ?? "",
                        hintText: state.endTime.isEmpty
                            ? (l10n?.selectTime ?? "")
                            : state.endTime,
                        suffixIcon: AppAssets.clock,
                        readOnly: true,
                        onTap: () => cubit.pickEndTime(context),
                        error: state.endTimeError,
                      ),
                    ),
                  ],
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.purposeOfBooking ?? "",
                  hintText: l10n?.selectPurposeOfBooking ?? "",
                  items: cubit.purposes,
                  value: state.purpose,
                  itemAsString: (value) => value,
                  onChanged: cubit.onPurposeChanged,
                  error: state.purposeError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.amount ?? "",
                  hintText: l10n?.enterAmount ?? "",
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: cubit.onAmountChanged,
                  error: state.amountError,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
