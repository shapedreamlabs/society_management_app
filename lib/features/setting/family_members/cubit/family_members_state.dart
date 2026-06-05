part of 'family_members_cubit.dart';

class FamilyMembersState extends Equatable {
  const FamilyMembersState({this.members = const []});

  final List<FamilyMemberModel> members;

  FamilyMembersState copyWith({List<FamilyMemberModel>? members}) {
    return FamilyMembersState(members: members ?? this.members);
  }

  @override
  List<Object?> get props => [members];
}
