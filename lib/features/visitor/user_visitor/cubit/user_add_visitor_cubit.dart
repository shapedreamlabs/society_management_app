import 'package:society_managment/society_managment.dart';

part 'user_add_visitor_state.dart';

class UserAddVisitorCubit extends Cubit<UserAddVisitorState> {
  UserAddVisitorCubit() : super(const UserAddVisitorState());

  final List<String> purposes = const [
    'Delivery',
    'Guest',
    'Service',
    'Personal',
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();

  void refresh(UserAddVisitorState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  void onPurposeChanged(String? value) {
    refresh(state.copyWith(purpose: value, purposeError: ''));
  }

  Future<void> onUploadImage(BuildContext context) async {
    try {
      final pickedFile = await MediaPicker.pickMedia(context: context);
      if (pickedFile == null) {
        return;
      }

      refresh(state.copyWith(visitorImage: pickedFile, hasCustomImage: true));
    } catch (exception, stack) {
      showCatchToast(exception, stack);
    }
  }

  void onRemoveImage() {
    refresh(state.copyWith(clearVisitorImage: true, hasCustomImage: false));
  }

  Future<void> pickVisitDate(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) {
      return;
    }

    refresh(state.copyWith(visitDate: _formatDate(pickedDate), dateError: ''));
  }

  Future<void> pickVisitTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) {
      return;
    }

    refresh(state.copyWith(visitTime: _formatTime(pickedTime), timeError: ''));
  }

  String _formatDate(DateTime pickedDate) {
    final day = pickedDate.day.toString().padLeft(2, '0');
    final month = pickedDate.month.toString().padLeft(2, '0');
    final year = pickedDate.year.toString();
    return '$day/$month/$year';
  }

  String _formatTime(TimeOfDay pickedTime) {
    final hour = pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod;
    final minute = pickedTime.minute.toString().padLeft(2, '0');
    final period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  bool validation(BuildContext context) {
    final requiredText = context.l10n?.fieldIsRequired ?? '';

    final nameError = nameController.text.trim().isEmpty ? requiredText : '';
    final phoneError = phoneController.text.trim().isEmpty ? requiredText : '';
    final dateError = state.visitDate.trim().isEmpty ? requiredText : '';
    final timeError = state.visitTime.trim().isEmpty ? requiredText : '';
    final purposeError = (state.purpose ?? '').isEmpty ? requiredText : '';

    refresh(
      state.copyWith(
        nameError: nameError,
        phoneError: phoneError,
        dateError: dateError,
        timeError: timeError,
        purposeError: purposeError,
      ),
    );

    return nameError.isEmpty &&
        phoneError.isEmpty &&
        dateError.isEmpty &&
        timeError.isEmpty &&
        purposeError.isEmpty;
  }

  Future<void> onSubmit(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(loader: true));

    try {
      if (!context.mounted) {
        return;
      }
      context.navigator.pop(true);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(loader: false));
      }
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    vehicleController.dispose();
    return super.close();
  }
}
