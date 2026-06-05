part of 'add_income_cubit.dart';

class AddIncomeState extends Equatable {
  const AddIncomeState({
    this.loader = false,
    this.titleError = '',
    this.amountError = '',
    this.categoryError = '',
    this.receivedFromError = '',
    this.paymentMethodError = '',
    this.dateError = '',
    this.category,
    this.receivedFrom,
    this.paymentMethod,
    this.date = '',
  });

  final bool loader;
  final String titleError;
  final String amountError;
  final String categoryError;
  final String receivedFromError;
  final String paymentMethodError;
  final String dateError;
  final String? category;
  final String? receivedFrom;
  final String? paymentMethod;
  final String date;

  AddIncomeState copyWith({
    bool? loader,
    String? titleError,
    String? amountError,
    String? categoryError,
    String? receivedFromError,
    String? paymentMethodError,
    String? dateError,
    String? category,
    String? receivedFrom,
    String? paymentMethod,
    String? date,
  }) {
    return AddIncomeState(
      loader: loader ?? this.loader,
      titleError: titleError ?? this.titleError,
      amountError: amountError ?? this.amountError,
      categoryError: categoryError ?? this.categoryError,
      receivedFromError: receivedFromError ?? this.receivedFromError,
      paymentMethodError: paymentMethodError ?? this.paymentMethodError,
      dateError: dateError ?? this.dateError,
      category: category ?? this.category,
      receivedFrom: receivedFrom ?? this.receivedFrom,
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
    receivedFromError,
    paymentMethodError,
    dateError,
    category,
    receivedFrom,
    paymentMethod,
    date,
  ];
}
