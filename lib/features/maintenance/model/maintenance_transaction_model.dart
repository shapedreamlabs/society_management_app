import 'package:equatable/equatable.dart';

class MaintenanceTransaction extends Equatable {
  const MaintenanceTransaction({
    required this.name,
    required this.flat,
    required this.category,
    required this.amount,
    required this.isCredit,
    required this.date,
  });

  final String name;
  final String flat;
  final String category;
  final String amount;
  final bool isCredit;
  final String date;

  @override
  List<Object?> get props => [name, flat, category, amount, isCredit, date];
}
