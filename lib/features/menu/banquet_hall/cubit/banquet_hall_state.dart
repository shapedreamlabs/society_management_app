part of 'banquet_hall_cubit.dart';

class BanquetHallState extends Equatable {
  const BanquetHallState({
    required this.focusedMonth,
    required this.bookedDays,
    required this.selectedDay,
    required this.totalBookings,
    required this.totalEarning,
  });

  final DateTime focusedMonth;
  final List<int> bookedDays;
  final int? selectedDay;
  final int totalBookings;
  final String totalEarning;

  factory BanquetHallState.initial() {
    final now = DateTime.now();
    final focusedMonth = DateTime(now.year, now.month);

    return BanquetHallState(
      focusedMonth: focusedMonth,
      bookedDays: BanquetHallCubit._defaultBookedDays,
      selectedDay: now.day,
      totalBookings: 8,
      totalEarning: '12,000',
    );
  }

  BanquetHallState copyWith({
    DateTime? focusedMonth,
    List<int>? bookedDays,
    int? selectedDay,
    bool clearSelectedDay = false,
    int? totalBookings,
    String? totalEarning,
  }) {
    return BanquetHallState(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      bookedDays: bookedDays ?? this.bookedDays,
      selectedDay: clearSelectedDay ? null : (selectedDay ?? this.selectedDay),
      totalBookings: totalBookings ?? this.totalBookings,
      totalEarning: totalEarning ?? this.totalEarning,
    );
  }

  @override
  List<Object?> get props => [
    focusedMonth,
    bookedDays,
    selectedDay,
    totalBookings,
    totalEarning,
  ];
}
