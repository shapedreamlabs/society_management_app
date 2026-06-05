import 'package:equatable/equatable.dart';

enum MaintenancePaymentStatus { pending, completed }

enum MaintenanceMemberFilter { all, pending, completed }

class MaintenanceMember extends Equatable {
  const MaintenanceMember({
    required this.id,
    required this.name,
    required this.flat,
    required this.amount,
    this.status = MaintenancePaymentStatus.pending,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final String flat;
  final String amount;
  final MaintenancePaymentStatus status;
  final bool isSelected;

  MaintenanceMember copyWith({
    String? id,
    String? name,
    String? flat,
    String? amount,
    MaintenancePaymentStatus? status,
    bool? isSelected,
  }) {
    return MaintenanceMember(
      id: id ?? this.id,
      name: name ?? this.name,
      flat: flat ?? this.flat,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, flat, amount, status, isSelected];
}
