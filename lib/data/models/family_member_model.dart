import 'package:society_managment/society_management.dart';

class FamilyMemberModel extends Equatable {
  const FamilyMemberModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.occupation,
    required this.relation,
    this.vehicles = const [],
  });

  final String id;
  final String name;
  final String phone;
  final String occupation;
  final FamilyMemberRelation relation;
  final List<String> vehicles;

  FamilyMemberModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? occupation,
    FamilyMemberRelation? relation,
    List<String>? vehicles,
  }) {
    return FamilyMemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      occupation: occupation ?? this.occupation,
      relation: relation ?? this.relation,
      vehicles: vehicles ?? this.vehicles,
    );
  }

  @override
  List<Object?> get props => [id, name, phone, occupation, relation, vehicles];
}
