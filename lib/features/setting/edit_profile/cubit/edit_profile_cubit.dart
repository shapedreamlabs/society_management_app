import 'package:society_managment/society_managment.dart';
import 'package:society_managment/society_managment_extra.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(Map<String, dynamic>? data)
    : super(const EditProfileState()) {
    _prefillFromLocal();
  }

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
  final List<String> residentTypes = const [
    AppLabelKeys.owner,
    AppLabelKeys.tenant,
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final List<TextEditingController> vehicleControllers = [
    TextEditingController(),
  ];

  void refresh(EditProfileState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  void _prefillFromLocal() {
    nameController.text = userModel?.name ?? '';
    phoneNumberController.text = userModel?.phone ?? '';
    occupationController.text = userModel?.occupation ?? '';

    if (kDebugMode && (userModel?.name ?? '').isEmpty) {
      nameController.text = 'Amit Patel';
      phoneNumberController.text = '+91 98745 61234';
      occupationController.text = 'Accountant';
      vehicleControllers.first.text = 'GJ 05 PS 4262';
    }

    refresh(
      state.copyWith(
        profileImageUrl: userModel?.image,
        wing: kDebugMode ? 'A' : state.wing,
        flat: kDebugMode ? '101' : state.flat,
        moveInDate: kDebugMode ? '24 Jan 2025' : '',
        residentType: residentTypes.first,
      ),
    );
  }

  Future<void> onChangeProfile(BuildContext context) async {
    try {
      final pickedFile = await MediaPicker.pickMedia(context: context);
      if (pickedFile == null) return;

      refresh(
        state.copyWith(profileImage: pickedFile, clearProfileImage: false),
      );
    } catch (exception, stack) {
      showCatchToast(exception, stack);
    }
  }

  void onWingChanged(String? value) {
    refresh(state.copyWith(wing: value, wingError: ''));
  }

  void onFlatChanged(String? value) {
    refresh(state.copyWith(flat: value, flatError: ''));
  }

  void onResidentTypeChanged(String? value) {
    refresh(state.copyWith(residentType: value, residentTypeError: ''));
  }

  void onAddVehicle() {
    vehicleControllers.add(TextEditingController());
    refresh(state.copyWith(vehicleFieldCount: state.vehicleFieldCount + 1));
  }

  void onRemoveVehicle(int index) {
    if (state.vehicleFieldCount <= 1) return;
    if (index < 0 || index >= vehicleControllers.length) return;

    vehicleControllers[index].dispose();
    vehicleControllers.removeAt(index);
    refresh(state.copyWith(vehicleFieldCount: state.vehicleFieldCount - 1));
  }

  Future<void> pickMoveInDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;

    refresh(
      state.copyWith(
        moveInDate: pickedDate.formatDateFromDateTime(),
        moveInDateError: '',
      ),
    );
  }

  bool validation(BuildContext context) {
    final l10n = context.l10n;
    final requiredText = l10n?.fieldIsRequired ?? '';

    final nameError = nameController.text.trim().isEmpty ? requiredText : '';
    final phoneNumberError = phoneNumberController.text.trim().isEmpty
        ? requiredText
        : '';
    final occupationError = occupationController.text.trim().isEmpty
        ? requiredText
        : '';
    final wingError = (state.wing ?? '').isEmpty ? requiredText : '';
    final flatError = (state.flat ?? '').isEmpty ? requiredText : '';
    final moveInDateError = state.moveInDate.trim().isEmpty ? requiredText : '';
    final residentTypeError = (state.residentType ?? '').isEmpty
        ? requiredText
        : '';

    refresh(
      state.copyWith(
        nameError: nameError,
        phoneNumberError: phoneNumberError,
        occupationError: occupationError,
        wingError: wingError,
        flatError: flatError,
        moveInDateError: moveInDateError,
        residentTypeError: residentTypeError,
      ),
    );

    return nameError.isEmpty &&
        phoneNumberError.isEmpty &&
        occupationError.isEmpty &&
        wingError.isEmpty &&
        flatError.isEmpty &&
        moveInDateError.isEmpty &&
        residentTypeError.isEmpty;
  }

  Future<void> onTapSave(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(loader: true));

    try {
      final vehicles = vehicleControllers
          .map((controller) => controller.text.trim())
          .where((value) => value.isNotEmpty)
          .toList();

      final fields = <String, dynamic>{
        'name': nameController.text.trim(),
        'phone': phoneNumberController.text.trim(),
        'occupation': occupationController.text.trim(),
        'wing': state.wing,
        'flat': state.flat,
        'move_in_date': state.moveInDate,
        'resident_type': state.residentType,
        'vehicles': vehicles,
      };

      if (state.profileImage != null) {
        fields['image'] = state.profileImage!.path;
      }

      if (!context.mounted) return;
      context.navigator.pop(true);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(loader: false));
      }
    }
  }
}
