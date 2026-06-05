import 'package:society_managment/society_managment.dart';

part 'add_complain_state.dart';

class AddComplainCubit extends Cubit<AddComplainState> {
  AddComplainCubit() : super(const AddComplainState());

  final List<String> priorities = const [
    AppLabelKeys.low,
    AppLabelKeys.medium,
    AppLabelKeys.high,
  ];

  void onPriorityChanged(String? value) {
    emit(state.copyWith(priority: value));
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) {
      return;
    }

    emit(state.copyWith(date: _formatDate(pickedDate)));
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}
