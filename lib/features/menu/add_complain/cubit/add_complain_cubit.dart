import 'package:society_managment/society_managment.dart';

part 'add_complain_state.dart';

class AddComplainCubit extends Cubit<AddComplainState> {
  AddComplainCubit() : super(const AddComplainState());

  final List<String> priorities = const ['Low', 'Medium', 'High'];

  void onPriorityChanged(String? value) {
    emit(state.copyWith(priority: value));
  }
}
