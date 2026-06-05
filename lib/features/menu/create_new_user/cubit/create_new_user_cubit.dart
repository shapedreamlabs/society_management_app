import 'package:society_managment/society_managment.dart';

part 'create_new_user_state.dart';

class CreateNewUserCubit extends Cubit<CreateNewUserState> {
  CreateNewUserCubit() : super(const CreateNewUserState());

  final List<String> wings = const [
    AppLabelKeys.wingA,
    AppLabelKeys.wingB,
    AppLabelKeys.wingC,
  ];
  final List<String> flats = const ['A-101', 'A-102', 'B-203', 'C-305'];
  final List<String> roles = const [
    AppLabelKeys.owner,
    AppLabelKeys.tenant,
    AppLabelKeys.family,
  ];

  void onWingChanged(String? value) {
    emit(state.copyWith(wing: value));
  }

  void onFlatChanged(String? value) {
    emit(state.copyWith(flat: value));
  }

  void onRoleChanged(String? value) {
    emit(state.copyWith(role: value));
  }
}
