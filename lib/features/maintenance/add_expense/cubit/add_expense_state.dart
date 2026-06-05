part of 'add_expense_cubit.dart';

class AddExpenseState extends Equatable {
  const AddExpenseState({
    this.loader = false,
    this.titleError = '',
    this.amountError = '',
    this.categoryError = '',
    this.paidToError = '',
    this.paymentMethodError = '',
    this.dateError = '',
    this.category,
    this.paidTo,
    this.paymentMethod,
    this.date = '',
  });

  final bool loader;
  final String titleError;
  final String amountError;
  final String categoryError;
  final String paidToError;
  final String paymentMethodError;
  final String dateError;
  final String? category;
  final String? paidTo;
  final String? paymentMethod;
  final String date;

  AddExpenseState copyWith({
    bool? loader,
    String? titleError,
    String? amountError,
    String? categoryError,
    String? paidToError,
    String? paymentMethodError,
    String? dateError,
    String? category,
    String? paidTo,
    String? paymentMethod,
    String? date,
  }) {
    return AddExpenseState(
      loader: loader ?? this.loader,
      titleError: titleError ?? this.titleError,
      amountError: amountError ?? this.amountError,
      categoryError: categoryError ?? this.categoryError,
      paidToError: paidToError ?? this.paidToError,
      paymentMethodError: paymentMethodError ?? this.paymentMethodError,
      dateError: dateError ?? this.dateError,
      category: category ?? this.category,
      paidTo: paidTo ?? this.paidTo,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    titleError,
    amountError,
    categoryError,
    paidToError,
    paymentMethodError,
    dateError,
    category,
    paidTo,
    paymentMethod,
    date,
  ];
}
