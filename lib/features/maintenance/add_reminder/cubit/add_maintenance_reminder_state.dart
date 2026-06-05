part of 'add_maintenance_reminder_cubit.dart';

class AddMaintenanceReminderState extends Equatable {
  const AddMaintenanceReminderState({
    this.loader = false,
    this.wingError = '',
    this.flatError = '',
    this.amountError = '',
    this.billingMonthError = '',
    this.wing,
    this.flat,
    this.billingMonth = '',
  });

  final bool loader;
  final String wingError;
  final String flatError;
  final String amountError;
  final String billingMonthError;
  final String? wing;
  final String? flat;
  final String billingMonth;

  AddMaintenanceReminderState copyWith({
    bool? loader,
    String? wingError,
    String? flatError,
    String? amountError,
    String? billingMonthError,
    String? wing,
    String? flat,
    String? billingMonth,
  }) {
    return AddMaintenanceReminderState(
      loader: loader ?? this.loader,
      wingError: wingError ?? this.wingError,
      flatError: flatError ?? this.flatError,
      amountError: amountError ?? this.amountError,
      billingMonthError: billingMonthError ?? this.billingMonthError,
      wing: wing ?? this.wing,
      flat: flat ?? this.flat,
      billingMonth: billingMonth ?? this.billingMonth,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    wingError,
    flatError,
    amountError,
    billingMonthError,
    wing,
    flat,
    billingMonth,
  ];
}
