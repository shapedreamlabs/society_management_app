import 'package:society_managment/society_managment.dart';

class FamilyMembersScreen extends StatelessWidget {
  const FamilyMembersScreen({super.key});

  static const routeName = '/family_members';

  static Widget builder(BuildContext context) {
    return BlocProvider<FamilyMembersCubit>(
      create: (_) => FamilyMembersCubit(),
      child: const FamilyMembersScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<FamilyMembersCubit, FamilyMembersState>(
      builder: (context, state) {
        final cubit = context.read<FamilyMembersCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.familyMember ?? '',
            centerTitle: true,
            color: AppColors.bgColor,
            titleStyle: styleW600S24,
            backIconColor: AppColors.text,
          ),
          floatingActionButton: CommonFloatingActionButton(
            onPressed: () => cubit.onTapAdd(context),
            child: SvgAsset(
              imagePath: AppAssets.add,
              height: 24.h,
              color: AppColors.white,
            ),
          ),
          body: state.members.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Text(
                      l10n?.noFamilyMembersAvailable ?? '',
                      textAlign: TextAlign.center,
                      style: styleW400S16.copyWith(
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    AppConstants.horizontalPadding,
                    12.h,
                    AppConstants.horizontalPadding,
                    88.h,
                  ),
                  itemCount: state.members.length,
                  separatorBuilder: (_, _) => 12.h.spaceVertical,
                  itemBuilder: (context, index) {
                    final member = state.members[index];
                    return FamilyMemberItemWidget(
                      familyMember: member,
                      onTapEdit: () => cubit.onTapEditMember(context, index),
                      onTapDelete: () =>
                          cubit.onTapDeleteMember(context, index),
                    );
                  },
                ),
        );
      },
    );
  }
}

class FamilyMemberItemWidget extends StatelessWidget {
  const FamilyMemberItemWidget({
    super.key,
    required this.familyMember,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  final FamilyMemberModel familyMember;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    final relation = familyMember.relation;

    return Container(
      padding: .all(15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Text(familyMember.name, style: styleW700S16),

          4.h.spaceVertical,

          Text(
            familyMember.phone,
            style: styleW500S14.copyWith(
              color: AppColors.text.withValues(alpha: 0.8),
            ),
          ),

          6.h.spaceVertical,

          Row(
            spacing: 10.w,
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: FamilyMemberRelation.getColor(
                    relation,
                  ).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  FamilyMemberRelation.getString(context, relation),
                  style: styleW600S14.copyWith(
                    color: FamilyMemberRelation.getColor(relation),
                  ),
                ),
              ),

              Row(
                spacing: 5.h,
                mainAxisSize: .min,
                children: [
                  CustomIconButton(
                    icon: AppAssets.edit1,
                    buttonColor: AppColors.text,
                    size: 20.h,
                    radius: 10.r,
                    onTap: onTapEdit,
                  ),

                  Container(
                    width: 1.w,
                    height: 20.h,
                    color: AppColors.text.withValues(alpha: 0.1),
                  ),

                  CustomIconButton(
                    icon: AppAssets.delete,
                    buttonColor: AppColors.red,
                    size: 20.h,
                    radius: 10.r,
                    onTap: onTapDelete,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
