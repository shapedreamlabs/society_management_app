import 'package:society_managment/society_managment.dart';

part 'add_family_member_state.dart';

class AddFamilyMemberCubit extends Cubit<AddFamilyMemberState> {
  AddFamilyMemberCubit(FamilyMemberModel? member)
    : _editingId = member?.id,
      super(
        AddFamilyMemberState(
          isEdit: member != null,
          occupation: member?.occupation,
          relation: member?.relation,
          vehicleFieldCount: (member?.vehicles.isEmpty ?? true)
              ? 1
              : member!.vehicles.length,
        ),
      ) {
    _prefill(member);
  }

  final String? _editingId;

  final List<String> occupations = const [
    AppLabelKeys.accountant,
    AppLabelKeys.engineer,
    AppLabelKeys.doctor,
    AppLabelKeys.teacher,
    AppLabelKeys.lawyer,
    AppLabelKeys.business,
    AppLabelKeys.student,
    AppLabelKeys.homemaker,
    AppLabelKeys.other,
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late final List<TextEditingController> vehicleControllers;

  void refresh(AddFamilyMemberState newState) {
    if (!isClosed) emit(newState);
  }

  void _prefill(FamilyMemberModel? member) {
    if (member == null) {
      vehicleControllers = [TextEditingController()];
      return;
    }

    nameController.text = member.name;
    phoneController.text = member.phone;
    vehicleControllers = member.vehicles.isEmpty
        ? [TextEditingController()]
        : member.vehicles.map((v) => TextEditingController(text: v)).toList();
  }

  List<FamilyMemberRelation> relations(BuildContext context) {
    return FamilyMemberRelation.getRelationsList(context);
  }

  void onOccupationChanged(String? value) {
    refresh(state.copyWith(occupation: value, occupationError: ''));
  }

  void onRelationChanged(FamilyMemberRelation? value) {
    refresh(state.copyWith(relation: value, relationError: ''));
  }

  void onAddVehicle() {
    vehicleControllers.add(TextEditingController());
    refresh(state.copyWith(vehicleFieldCount: state.vehicleFieldCount + 1));
  }

  void onRemoveVehicle(int index) {
    if (state.vehicleFieldCount <= 1 || index <= 0) return;
    if (index >= vehicleControllers.length) return;

    vehicleControllers[index].dispose();
    vehicleControllers.removeAt(index);
    refresh(state.copyWith(vehicleFieldCount: state.vehicleFieldCount - 1));
  }

  bool validate(BuildContext context) {
    final requiredText = context.l10n?.fieldIsRequired ?? '';

    final nameError = nameController.text.trim().isEmpty ? requiredText : '';
    final phoneError = phoneController.text.trim().isEmpty ? requiredText : '';
    final occupationError = (state.occupation ?? '').isEmpty
        ? requiredText
        : '';
    final relationError = state.relation == null ? requiredText : '';

    refresh(
      state.copyWith(
        nameError: nameError,
        phoneError: phoneError,
        occupationError: occupationError,
        relationError: relationError,
      ),
    );

    return nameError.isEmpty &&
        phoneError.isEmpty &&
        occupationError.isEmpty &&
        relationError.isEmpty;
  }

  void onSubmit(BuildContext context) {
    if (!validate(context)) return;

    hideKeyboard(context: context);

    final vehicles = vehicleControllers
        .map((c) => c.text.trim())
        .where((v) => v.isNotEmpty)
        .toList();

    final member = FamilyMemberModel(
      id: _editingId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      occupation: state.occupation!,
      relation: state.relation!,
      vehicles: vehicles,
    );

    context.navigator.pop(member);
  }
}
