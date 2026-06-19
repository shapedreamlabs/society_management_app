import 'package:society_managment/society_management.dart';

part 'family_members_state.dart';

class FamilyMembersCubit extends Cubit<FamilyMembersState> {
  FamilyMembersCubit() : super(const FamilyMembersState()) {
    _loadMembers();
  }

  static List<FamilyMemberModel> _debugMembers() => const [
    FamilyMemberModel(
      id: '1',
      name: 'Aarav Amitbhai Patel',
      phone: '+91 99255 59824',
      occupation: AppLabelKeys.student,
      relation: FamilyMemberRelation.son,
      vehicles: ['GJ 05 AB 1234'],
    ),
    FamilyMemberModel(
      id: '2',
      name: 'Rajesh Amitbhai Patel',
      phone: '+91 98765 43210',
      occupation: AppLabelKeys.business,
      relation: FamilyMemberRelation.father,
      vehicles: [],
    ),
    FamilyMemberModel(
      id: '3',
      name: 'Priya Amitbhai Patel',
      phone: '+91 99887 76655',
      occupation: AppLabelKeys.teacher,
      relation: FamilyMemberRelation.daughter,
      vehicles: ['GJ 05 CD 5678'],
    ),
  ];

  void _loadMembers() {
    if (AppConstants.useMockData) {
      emit(FamilyMembersState(members: _debugMembers()));
    }
  }

  Future<void> onTapAdd(BuildContext context) async {
    final result = await context.navigator.pushNamed(
      AddFamilyMemberScreen.routeName,
    );
    if (result is FamilyMemberModel) {
      _upsertMember(result);
    }
  }

  Future<void> onTapEditMember(BuildContext context, int index) async {
    if (index < 0 || index >= state.members.length) return;
    await onTapEdit(context, state.members[index]);
  }

  Future<void> onTapDeleteMember(BuildContext context, int index) async {
    if (index < 0 || index >= state.members.length) return;
    await onTapDelete(context, state.members[index]);
  }

  Future<void> onTapEdit(BuildContext context, FamilyMemberModel member) async {
    final result = await context.navigator.pushNamed(
      AddFamilyMemberScreen.routeName,
      arguments: member,
    );
    if (result is FamilyMemberModel) {
      _upsertMember(result);
    }
  }

  void _upsertMember(FamilyMemberModel member) {
    final index = state.members.indexWhere((m) => m.id == member.id);
    final updated = List<FamilyMemberModel>.from(state.members);
    if (index >= 0) {
      updated[index] = member;
    } else {
      updated.add(member);
    }
    emit(state.copyWith(members: updated));
  }

  Future<void> onTapDelete(
    BuildContext context,
    FamilyMemberModel member,
  ) async {
    final confirmed = await showDeleteFamilyMemberSheet(context);
    if (confirmed == true) {
      final updated = state.members.where((m) => m.id != member.id).toList();
      emit(state.copyWith(members: updated));
    }
  }
}

Future<bool?> showDeleteFamilyMemberSheet(BuildContext context) {
  return AppBottomSheet.show<bool>(
    context: context,
    child: const DeleteFamilyMemberSheet(),
  );
}

class DeleteFamilyMemberSheet extends StatelessWidget {
  const DeleteFamilyMemberSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.navigator.pop(false),
                borderRadius: BorderRadius.circular(10.r),
                child: SvgAsset(imagePath: AppAssets.close, height: 24.h),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.red.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.red.withValues(alpha: 0.08),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(23.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.red.withValues(alpha: 0.08),
                    ),
                    child: Center(
                      child: SvgAsset(
                        imagePath: AppAssets.delete,
                        height: 40.h,
                        color: AppColors.logoutRed,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
            child: Text(l10n?.deleteMember ?? '', style: styleW700S20),
          ),
          Text(
            l10n?.deleteMemberContent ?? '',
            textAlign: TextAlign.center,
            style: styleW400S14.copyWith(color: AppColors.grey),
          ),
          20.h.spaceVertical,
          CustomButton(
            title: l10n?.yesDelete ?? '',
            buttonColor: AppColors.logoutRed,
            onTap: () => context.navigator.pop(true),
          ),
        ],
      ),
    );
  }
}
