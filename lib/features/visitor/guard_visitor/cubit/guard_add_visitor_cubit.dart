import 'package:society_managment/society_management.dart';

part 'guard_add_visitor_state.dart';

class GuardAddVisitorCubit extends Cubit<GuardAddVisitorState> {
  GuardAddVisitorCubit() : super(const GuardAddVisitorState());

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
  final List<String> purposes = const [
    AppLabelKeys.delivery,
    AppLabelKeys.guest,
    AppLabelKeys.service,
    AppLabelKeys.personal,
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();

  void refresh(GuardAddVisitorState newState) {
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

  bool validation(BuildContext context) {
    final requiredText = context.l10n?.fieldIsRequired ?? '';

    final nameError = nameController.text.trim().isEmpty ? requiredText : '';
    final phoneError = phoneController.text.trim().isEmpty ? requiredText : '';
    final wingError = (state.wing ?? '').isEmpty ? requiredText : '';
    final flatError = (state.flat ?? '').isEmpty ? requiredText : '';
    final purposeError = (state.purpose ?? '').isEmpty ? requiredText : '';

    refresh(
      state.copyWith(
        nameError: nameError,
        phoneError: phoneError,
        wingError: wingError,
        flatError: flatError,
        purposeError: purposeError,
      ),
    );

    return nameError.isEmpty &&
        phoneError.isEmpty &&
        wingError.isEmpty &&
        flatError.isEmpty &&
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
