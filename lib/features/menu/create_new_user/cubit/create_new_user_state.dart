part of 'create_new_user_cubit.dart';

class CreateNewUserState extends Equatable {
  const CreateNewUserState({this.wing, this.flat, this.role});

  final String? wing;
  final String? flat;
  final String? role;

  CreateNewUserState copyWith({String? wing, String? flat, String? role}) {
    return CreateNewUserState(
      wing: wing ?? this.wing,
      flat: flat ?? this.flat,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [wing, flat, role];
}
