import 'package:society_managment/society_management.dart';

part 'add_maintenance_reminder_state.dart';

class AddMaintenanceReminderCubit extends Cubit<AddMaintenanceReminderState> {
  AddMaintenanceReminderCubit() : super(const AddMaintenanceReminderState());

  final List<String> wings = const ['A', 'B', 'C'];
  final List<String> flats = const [
    '101',
    '102',
    '103',
    '104',
    '105',
    '201',
    '203',
    '305',
  ];

  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  void refresh(AddMaintenanceReminderState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  String wingLabel(BuildContext context, String wing) {
    final l10n = context.l10n;
    switch (wing) {
      case 'A':
        return l10n?.wingA ?? wing;
      case 'B':
        return l10n?.wingB ?? wing;
      case 'C':
        return l10n?.wingC ?? wing;
      default:
        return wing;
    }
  }

  void onWingChanged(String? value) {
    refresh(state.copyWith(wing: value, wingError: ''));
  }

  void onFlatChanged(String? value) {
    refresh(state.copyWith(flat: value, flatError: ''));
  }

  Future<void> pickBillingMonth(BuildContext context) async {
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

    refresh(
      state.copyWith(
        billingMonth: _formatDate(pickedDate),
        billingMonthError: '',
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  bool validation(BuildContext context) {
    final l10n = context.l10n;
    final requiredText = l10n?.fieldIsRequired ?? '';
    final amountInvalid = l10n?.amountIsInvalid ?? '';

    final wingError = (state.wing ?? '').isEmpty ? requiredText : '';
    final flatError = (state.flat ?? '').isEmpty ? requiredText : '';
    final amountText = amountController.text.trim();
    final amountError = amountText.isEmpty
        ? requiredText
        : (!_isNumeric(amountText) ? amountInvalid : '');
    final billingMonthError = state.billingMonth.trim().isEmpty
        ? requiredText
        : '';

    refresh(
      state.copyWith(
        wingError: wingError,
        flatError: flatError,
        amountError: amountError,
        billingMonthError: billingMonthError,
      ),
    );

    return wingError.isEmpty &&
        flatError.isEmpty &&
        amountError.isEmpty &&
        billingMonthError.isEmpty;
  }

  bool _isNumeric(String value) {
    return RegExp(r'^\d+(\.\d+)?$').hasMatch(value.replaceAll(',', ''));
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
    amountController.dispose();
    notesController.dispose();
    return super.close();
  }
}
