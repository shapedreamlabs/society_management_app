import 'package:society_managment/society_managment.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(const AddExpenseState());

  final List<String> categories = const [
    'Maintenance',
    'Security',
    'Utilities',
    'Repairs',
    'Other',
  ];
  final List<String> persons = const [
    'Suresh Doshi',
    'Meera Patel',
    'Rahul Shah',
    'Vendor',
  ];
  final List<String> paymentMethods = const [
    'Cash',
    'UPI',
    'Bank Transfer',
    'Cheque',
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  void refresh(AddExpenseState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  void onCategoryChanged(String? value) {
    refresh(state.copyWith(category: value, categoryError: ''));
  }

  void onPaidToChanged(String? value) {
    refresh(state.copyWith(paidTo: value, paidToError: ''));
  }

  void onPaymentMethodChanged(String? value) {
    refresh(state.copyWith(paymentMethod: value, paymentMethodError: ''));
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

    refresh(state.copyWith(date: _formatDate(pickedDate), dateError: ''));
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

    final titleError = titleController.text.trim().isEmpty ? requiredText : '';
    final amountText = amountController.text.trim();
    final amountError = amountText.isEmpty
        ? requiredText
        : (!_isNumeric(amountText) ? amountInvalid : '');
    final categoryError = (state.category ?? '').isEmpty ? requiredText : '';
    final paidToError = (state.paidTo ?? '').isEmpty ? requiredText : '';
    final paymentMethodError = (state.paymentMethod ?? '').isEmpty
        ? requiredText
        : '';
    final dateError = state.date.trim().isEmpty ? requiredText : '';

    refresh(
      state.copyWith(
        titleError: titleError,
        amountError: amountError,
        categoryError: categoryError,
        paidToError: paidToError,
        paymentMethodError: paymentMethodError,
        dateError: dateError,
      ),
    );

    return titleError.isEmpty &&
        amountError.isEmpty &&
        categoryError.isEmpty &&
        paidToError.isEmpty &&
        paymentMethodError.isEmpty &&
        dateError.isEmpty;
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
    titleController.dispose();
    amountController.dispose();
    notesController.dispose();
    return super.close();
  }
}
