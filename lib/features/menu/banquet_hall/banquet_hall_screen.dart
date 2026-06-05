import 'package:society_managment/society_managment.dart';

class BanquetHallScreen extends StatelessWidget {
  const BanquetHallScreen({super.key});

  static const routeName = '/banquet_hall';

  static Widget builder(BuildContext context) {
    return BlocProvider<BanquetHallCubit>(
      create: (_) => BanquetHallCubit(),
      child: const BanquetHallScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      floatingActionButton: BlocBuilder<BanquetHallCubit, BanquetHallState>(
        builder: (context, _) {
          return CommonFloatingActionButton(
            onPressed: () =>
                context.read<BanquetHallCubit>().onAddBookingTap(context),
            child: SvgAsset(
              imagePath: AppAssets.add,
              height: 24.h,
              color: AppColors.white,
            ),
          );
        },
      ),
      body: BlocBuilder<BanquetHallCubit, BanquetHallState>(
        builder: (context, state) {
          final cubit = context.read<BanquetHallCubit>();
          final bookings = cubit.bookings;

          return Column(
            children: [
              // Calender View
              _BanquetCalendarHeader(cubit: cubit, l10n: l10n),

              // Hall Bookings Data
              Expanded(
                child: CustomSingleChildScroll(
                  padding: EdgeInsets.fromLTRB(
                    AppConstants.horizontalPadding,
                    16.h,
                    AppConstants.horizontalPadding,
                    90.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CommonOverviewCard(
                              imagePath: AppAssets.calenderFillImg,
                              value: state.totalBookings.toString().padLeft(
                                2,
                                '0',
                              ),
                              title: l10n?.totalBooking ?? '',
                            ),
                          ),

                          12.w.spaceHorizontal,

                          Expanded(
                            child: CommonOverviewCard(
                              imagePath: AppAssets.moneyImg,
                              value: '₹${state.totalEarning}',
                              title: l10n?.totalEarning ?? '',
                            ),
                          ),
                        ],
                      ),

                      20.h.spaceVertical,

                      Text(l10n?.hallBooking ?? "", style: styleW600S18),

                      12.h.spaceVertical,

                      if (bookings.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Text(
                              l10n?.noBookingsAvailable ?? "",
                              style: styleW400S16.copyWith(
                                color: AppColors.text.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          padding: .zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bookings.length,
                          separatorBuilder: (_, _) => 12.h.spaceVertical,
                          itemBuilder: (context, index) {
                            final item = bookings[index];
                            return BanquetBookingCard(
                              name: item['name'] ?? '',
                              flat: item['flat'] ?? '',
                              phone: item['phone'] ?? '',
                              status: item['status'] ?? '',
                              date: item['date'] ?? '',
                              time: item['time'] ?? '',
                              purpose: item['purpose'] ?? '',
                              completedLabel: l10n?.completed ?? "",
                              pendingLabel: l10n?.pending ?? "",
                              dateLabel: l10n?.date ?? "",
                              timeLabel: l10n?.time ?? "",
                              purposeLabel: l10n?.purpose ?? "",
                            );
                          },
                        ),
                    ],
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

class _BanquetCalendarHeader extends StatelessWidget {
  const _BanquetCalendarHeader({required this.cubit, required this.l10n});

  final BanquetHallCubit cubit;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    final weekDays = LocalizationLabels.weekdayLabels(l10n);

    return Container(
      width: double.infinity,
      color: AppColors.blue,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: AppConstants.horizontalPadding,
        right: AppConstants.horizontalPadding,
        bottom: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.h.spaceVertical,
          Row(
            children: [
              Container(
                width: 36.w,
                margin: .only(right: 14.w),
                child: CustomIconButton(
                  icon: AppAssets.backArrow,
                  size: 20.h,
                  padding: 0,
                  onTap: context.navigator.pop,
                ),
              ),
              Center(
                child: Text(
                  l10n?.banquetHall ?? "",
                  textAlign: TextAlign.center,
                  style: styleW600S24.copyWith(color: AppColors.white),
                ),
              ),

              SizedBox(width: 36.w),
            ],
          ),

          20.h.spaceVertical,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MonthNavButton(
                icon: Icons.chevron_left,
                onTap: cubit.onPreviousMonth,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        cubit.monthYearLabel(
                          Localizations.localeOf(context).toString(),
                        ),
                        style: styleW600S18.copyWith(color: AppColors.white),
                      ),
                      4.h.spaceVertical,
                      Text(
                        cubit.bookingCountLabel(l10n),
                        style: styleW400S14.copyWith(
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _MonthNavButton(
                icon: Icons.chevron_right,
                onTap: cubit.onNextMonth,
              ),
            ],
          ),
          16.h.spaceVertical,
          Row(
            children: weekDays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: styleW500S12.copyWith(
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          8.h.spaceVertical,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6.h,
              crossAxisSpacing: 6.w,
              childAspectRatio: 1,
            ),
            itemCount: cubit.firstWeekdayOffset + cubit.daysInMonth,
            itemBuilder: (context, index) {
              if (index < cubit.firstWeekdayOffset) {
                return const SizedBox.shrink();
              }
              final day = index - cubit.firstWeekdayOffset + 1;
              final isSelected = cubit.isSelectedDay(day);
              final isBooked = cubit.isBookedDay(day);

              final backgroundColor = isSelected
                  ? AppColors.orange
                  : isBooked
                  ? AppColors.orange.withValues(alpha: 0.18)
                  : AppColors.white.withValues(alpha: 0.1);

              final textColor = isSelected
                  ? AppColors.white
                  : isBooked
                  ? AppColors.orange
                  : AppColors.white;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => cubit.onDaySelected(day),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: isBooked && !isSelected
                          ? Border.all(color: AppColors.orange, width: 1)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$day',
                          style: styleW500S14.copyWith(color: textColor),
                        ),
                        if (isBooked && !isSelected) ...[
                          4.h.spaceVertical,
                          Container(
                            width: 5.w,
                            height: 5.w,
                            decoration: const BoxDecoration(
                              color: AppColors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          12.h.spaceVertical,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24.w,
            children: [
              _LegendItem(
                color: AppColors.white.withValues(alpha: 0.5),
                label: l10n?.booked ?? "",
              ),
              _LegendItem(color: AppColors.orange, label: l10n?.today ?? ""),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthNavButton extends StatelessWidget {
  const _MonthNavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 36.w,
          height: 36.w,
          child: Icon(icon, color: AppColors.text, size: 22.h),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        6.w.spaceHorizontal,
        Text(
          label,
          style: styleW400S12.copyWith(
            color: AppColors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
