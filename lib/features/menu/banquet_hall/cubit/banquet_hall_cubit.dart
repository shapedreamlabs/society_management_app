import 'package:society_managment/society_managment.dart';

part 'banquet_hall_state.dart';

class BanquetHallCubit extends Cubit<BanquetHallState> {
  BanquetHallCubit() : super(BanquetHallState.initial());

  static const List<int> _defaultBookedDays = [4, 9, 13, 17, 20, 24, 28, 30];

  static const List<Map<String, String>> _debugBookings = [
    {
      'name': 'Suresh Patel',
      'flat': 'A-101',
      'phone': '9876543210',
      'status': 'completed',
      'date': '04 Apr 2026',
      'time': '06 PM - 10 PM',
      'purpose': 'Birthday Party',
    },
    {
      'name': 'Ramesh Shah',
      'flat': 'B-203',
      'phone': '9876501234',
      'status': 'pending',
      'date': '09 Apr 2026',
      'time': '04 PM - 08 PM',
      'purpose': 'Marriage',
    },
    {
      'name': 'Priya Mehta',
      'flat': 'C-305',
      'phone': '9876512345',
      'status': 'completed',
      'date': '13 Apr 2026',
      'time': '05 PM - 09 PM',
      'purpose': 'Engagement',
    },
  ];

  List<Map<String, String>> get bookings {
    if (AppConstants.useMockData) {
      return _debugBookings;
    }
    return [];
  }

  void onPreviousMonth() {
    final month = state.focusedMonth;
    final newMonth = DateTime(month.year, month.month - 1);
    emit(
      state.copyWith(
        focusedMonth: newMonth,
        selectedDay: _selectedDayForMonth(newMonth),
        clearSelectedDay: _selectedDayForMonth(newMonth) == null,
      ),
    );
  }

  void onNextMonth() {
    final month = state.focusedMonth;
    final newMonth = DateTime(month.year, month.month + 1);
    emit(
      state.copyWith(
        focusedMonth: newMonth,
        selectedDay: _selectedDayForMonth(newMonth),
        clearSelectedDay: _selectedDayForMonth(newMonth) == null,
      ),
    );
  }

  void onDaySelected(int day) {
    emit(state.copyWith(selectedDay: day));
  }

  int? _selectedDayForMonth(DateTime month) {
    final now = DateTime.now();
    if (now.year == month.year && now.month == month.month) {
      return now.day;
    }
    return null;
  }

  void onAddBookingTap(BuildContext context) {
    context.navigator.pushNamed(BookBanquetHallScreen.routeName);
  }

  String monthYearLabel(String localeName) {
    return LocalizationLabels.formatMonthYear(state.focusedMonth, localeName);
  }

  String bookingCountLabel(AppLocalizations? l10n) {
    final count = state.bookedDays.length.toString().padLeft(2, '0');
    return '$count ${l10n?.booking ?? ''}';
  }

  int get daysInMonth {
    final month = state.focusedMonth;
    return DateTime(month.year, month.month + 1, 0).day;
  }

  int get firstWeekdayOffset {
    final month = state.focusedMonth;
    return DateTime(month.year, month.month, 1).weekday % 7;
  }

  bool isBookedDay(int day) => state.bookedDays.contains(day);

  bool isSelectedDay(int day) => state.selectedDay == day;

  bool isTodayDay(int day) {
    final now = DateTime.now();
    final month = state.focusedMonth;
    return now.year == month.year && now.month == month.month && now.day == day;
  }
}
