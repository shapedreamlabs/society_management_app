part of 'book_banquet_hall_cubit.dart';

class BookBanquetHallState extends Equatable {
  const BookBanquetHallState({
    this.name = '',
    this.contactNumber = '',
    this.startDate = '',
    this.endDate = '',
    this.startTime = '',
    this.endTime = '',
    this.purpose,
    this.amount = '',
    this.nameError,
    this.contactNumberError,
    this.startDateError,
    this.endDateError,
    this.startTimeError,
    this.endTimeError,
    this.purposeError,
    this.amountError,
  });

  final String name;
  final String contactNumber;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String? purpose;
  final String amount;
  final String? nameError;
  final String? contactNumberError;
  final String? startDateError;
  final String? endDateError;
  final String? startTimeError;
  final String? endTimeError;
  final String? purposeError;
  final String? amountError;

  BookBanquetHallState copyWith({
    String? name,
    String? contactNumber,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? purpose,
    String? amount,
    String? nameError,
    String? contactNumberError,
    String? startDateError,
    String? endDateError,
    String? startTimeError,
    String? endTimeError,
    String? purposeError,
    String? amountError,
    bool clearNameError = false,
    bool clearContactNumberError = false,
    bool clearStartDateError = false,
    bool clearEndDateError = false,
    bool clearStartTimeError = false,
    bool clearEndTimeError = false,
    bool clearPurposeError = false,
    bool clearAmountError = false,
  }) {
    return BookBanquetHallState(
      name: name ?? this.name,
      contactNumber: contactNumber ?? this.contactNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      nameError: clearNameError ? null : (nameError ?? this.nameError),
      contactNumberError: clearContactNumberError
          ? null
          : (contactNumberError ?? this.contactNumberError),
      startDateError: clearStartDateError
          ? null
          : (startDateError ?? this.startDateError),
      endDateError: clearEndDateError
          ? null
          : (endDateError ?? this.endDateError),
      startTimeError: clearStartTimeError
          ? null
          : (startTimeError ?? this.startTimeError),
      endTimeError: clearEndTimeError
          ? null
          : (endTimeError ?? this.endTimeError),
      purposeError: clearPurposeError
          ? null
          : (purposeError ?? this.purposeError),
      amountError: clearAmountError ? null : (amountError ?? this.amountError),
    );
  }

  @override
  List<Object?> get props => [
    name,
    contactNumber,
    startDate,
    endDate,
    startTime,
    endTime,
    purpose,
    amount,
    nameError,
    contactNumberError,
    startDateError,
    endDateError,
    startTimeError,
    endTimeError,
    purposeError,
    amountError,
  ];
}
