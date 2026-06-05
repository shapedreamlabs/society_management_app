part of 'add_family_member_cubit.dart';

class AddFamilyMemberState extends Equatable {
  const AddFamilyMemberState({
    this.isEdit = false,
    this.nameError = '',
    this.phoneError = '',
    this.occupationError = '',
    this.relationError = '',
    this.occupation,
    this.relation,
    this.vehicleFieldCount = 1,
  });

  final bool isEdit;
  final String nameError;
  final String phoneError;
  final String occupationError;
  final String relationError;
  final String? occupation;
  final FamilyMemberRelation? relation;
  final int vehicleFieldCount;

  AddFamilyMemberState copyWith({
    bool? isEdit,
    String? nameError,
    String? phoneError,
    String? occupationError,
    String? relationError,
    String? occupation,
    FamilyMemberRelation? relation,
    int? vehicleFieldCount,
  }) {
    return AddFamilyMemberState(
      isEdit: isEdit ?? this.isEdit,
      nameError: nameError ?? this.nameError,
      phoneError: phoneError ?? this.phoneError,
      occupationError: occupationError ?? this.occupationError,
      relationError: relationError ?? this.relationError,
      occupation: occupation ?? this.occupation,
      relation: relation ?? this.relation,
      vehicleFieldCount: vehicleFieldCount ?? this.vehicleFieldCount,
    );
  }

  @override
  List<Object?> get props => [
    isEdit,
    nameError,
    phoneError,
    occupationError,
    relationError,
    occupation,
    relation,
    vehicleFieldCount,
  ];
}
