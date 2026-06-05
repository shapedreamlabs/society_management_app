import 'package:society_managment/society_managment.dart';

part 'book_banquet_hall_state.dart';

class BookBanquetHallCubit extends Cubit<BookBanquetHallState> {
  BookBanquetHallCubit() : super(const BookBanquetHallState());

  final List<String> purposes = const [
    AppLabelKeys.birthdayCelebration,
    AppLabelKeys.engagementFunction,
    AppLabelKeys.societyMeeting,
  ];

  void onPurposeChanged(String? value) {
    emit(state.copyWith(purpose: value, clearPurposeError: true));
  }

  void onNameChanged(String value) {
    emit(state.copyWith(name: value, clearNameError: true));
  }

  void onContactNumberChanged(String value) {
    emit(state.copyWith(contactNumber: value, clearContactNumberError: true));
  }

  void onStartDateChanged(String value) {
    emit(state.copyWith(startDate: value, clearStartDateError: true));
  }

  void onEndDateChanged(String value) {
    emit(state.copyWith(endDate: value, clearEndDateError: true));
  }

  void onStartTimeChanged(String value) {
    emit(state.copyWith(startTime: value, clearStartTimeError: true));
  }

  void onEndTimeChanged(String value) {
    emit(state.copyWith(endTime: value, clearEndTimeError: true));
  }

  void onAmountChanged(String value) {
    emit(state.copyWith(amount: value, clearAmountError: true));
  }

  Future<void> pickStartDate(BuildContext context) async {
    final today = _todayDate();
    final pickedDate = await _pickDate(
      context,
      firstDate: today,
      initialDate: today,
    );
    if (pickedDate == null) return;
    onStartDateChanged(_formatDate(pickedDate));
  }

  Future<void> pickEndDate(BuildContext context) async {
    final today = _todayDate();
    final parsedStart = _tryParseDate(state.startDate);
    final firstEnd = (parsedStart != null && parsedStart.isAfter(today))
        ? parsedStart
        : today;

    final pickedDate = await _pickDate(
      context,
      firstDate: firstEnd,
      initialDate: firstEnd,
    );
    if (pickedDate == null) return;
    onEndDateChanged(_formatDate(pickedDate));
  }

  Future<void> pickStartTime(BuildContext context) async {
    final l10n = context.l10n;
    final pickedTime = await _pickTime(context);
    if (pickedTime == null) return;
    onStartTimeChanged(_formatTime(l10n, pickedTime));
  }

  Future<void> pickEndTime(BuildContext context) async {
    final l10n = context.l10n;
    final pickedTime = await _pickTime(context);
    if (pickedTime == null) return;
    onEndTimeChanged(_formatTime(l10n, pickedTime));
  }

  bool validate(AppLocalizations? l10n) {
    final requiredText = l10n?.fieldIsRequired ?? '';
    final phoneInvalidText = l10n?.phoneNumberIsInvalid ?? '';
    final amountInvalidText = l10n?.amountIsInvalid ?? '';
    final pastDateInvalidText = l10n?.pastDateNotAllowed ?? '';
    final endBeforeStartInvalidText = l10n?.endDateBeforeStartDate ?? '';

    final nowDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final nameError = state.name.trim().isEmpty ? requiredText : null;
    final contactNumberError = state.contactNumber.trim().isEmpty
        ? requiredText
        : (RegExp(r'^\d+$').hasMatch(state.contactNumber.trim())
              ? null
              : phoneInvalidText);
    String? startDateError = state.startDate.trim().isEmpty
        ? requiredText
        : null;
    String? endDateError = state.endDate.trim().isEmpty ? requiredText : null;
    final startTimeError = state.startTime.trim().isEmpty ? requiredText : null;
    final endTimeError = state.endTime.trim().isEmpty ? requiredText : null;
    final purposeError = (state.purpose ?? '').trim().isEmpty
        ? requiredText
        : null;
    final amountError = state.amount.trim().isEmpty
        ? requiredText
        : (RegExp(r'^\d+$').hasMatch(state.amount.trim())
              ? null
              : amountInvalidText);

    final parsedStart = _tryParseDate(state.startDate);
    final parsedEnd = _tryParseDate(state.endDate);

    if (parsedStart != null &&
        startDateError == null &&
        parsedStart.isBefore(nowDate)) {
      startDateError = pastDateInvalidText;
    }

    if (parsedStart != null &&
        parsedEnd != null &&
        endDateError == null &&
        parsedEnd.isBefore(parsedStart)) {
      endDateError = endBeforeStartInvalidText;
    }

    emit(
      state.copyWith(
        nameError: nameError,
        contactNumberError: contactNumberError,
        startDateError: startDateError,
        endDateError: endDateError,
        startTimeError: startTimeError,
        endTimeError: endTimeError,
        purposeError: purposeError,
        amountError: amountError,
      ),
    );

    return [
      nameError,
      contactNumberError,
      startDateError,
      endDateError,
      startTimeError,
      endTimeError,
      purposeError,
      amountError,
    ].every((error) => error == null);
  }

  void onBookNow(BuildContext context, AppLocalizations? l10n) {
    if (!validate(l10n)) return;
    context.navigator.pop();
  }

  DateTime _todayDate() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Future<DateTime?> _pickDate(
    BuildContext context, {
    required DateTime firstDate,
    DateTime? initialDate,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _pickTime(BuildContext context) async {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  String _formatDate(DateTime pickedDate) {
    final day = pickedDate.day.toString().padLeft(2, '0');
    final month = pickedDate.month.toString().padLeft(2, '0');
    final year = pickedDate.year.toString();
    return '$day/$month/$year';
  }

  String _formatTime(AppLocalizations? l10n, TimeOfDay pickedTime) {
    final hour = pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod;
    final minute = pickedTime.minute.toString().padLeft(2, '0');
    final period = LocalizationLabels.timePeriod(l10n, pickedTime.period);
    return '$hour:$minute $period';
  }

  DateTime? _tryParseDate(String date) {
    // Expected format: dd/MM/yyyy
    final parts = date.split('/');
    if (parts.length != 3) return null;

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;

    return DateTime(year, month, day);
  }
}
