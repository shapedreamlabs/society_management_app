import 'package:society_managment/society_management.dart';

class AddFamilyMemberScreen extends StatelessWidget {
  const AddFamilyMemberScreen({super.key});

  static const routeName = '/add_family_member';

  static Widget builder(BuildContext context) {
    final member = context.args is FamilyMemberModel
        ? context.args as FamilyMemberModel
        : null;

    return BlocProvider<AddFamilyMemberCubit>(
      create: (_) => AddFamilyMemberCubit(member),
      child: const AddFamilyMemberScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<AddFamilyMemberCubit, AddFamilyMemberState>(
      builder: (context, state) {
        final cubit = context.read<AddFamilyMemberCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: state.isEdit
                ? (l10n?.editMember ?? '')
                : (l10n?.addMember ?? ''),
            centerTitle: true,
            color: AppColors.bgColor,
            titleStyle: styleW600S24,
            backIconColor: AppColors.text,
          ),
          bottomNavigationBar: SafeArea(
            minimum: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              0,
              AppConstants.horizontalPadding,
              12.h,
            ),
            child: CustomButton(
              title: state.isEdit
                  ? (l10n?.save ?? '')
                  : (l10n?.addMember ?? ''),
              onTap: () => cubit.onSubmit(context),
            ),
          ),
          body: CustomSingleChildScroll(
            padding: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              12.h,
              AppConstants.horizontalPadding,
              16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: cubit.nameController,
                  header: l10n?.fullName ?? '',
                  hintText: l10n?.enterFullName ?? '',
                  error: state.nameError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  controller: cubit.phoneController,
                  header: l10n?.phoneNumber ?? '',
                  hintText: l10n?.enterPhoneNumber ?? '',
                  textInputType: TextInputType.phone,
                  error: state.phoneError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.occupation ?? '',
                  hintText: l10n?.selectOccupation ?? '',
                  items: cubit.occupations,
                  value: state.occupation,
                  itemAsString: (value) => LocalizationLabels.of(l10n, value),
                  onChanged: cubit.onOccupationChanged,
                  error: state.occupationError,
                ),
                14.h.spaceVertical,
                AppDropDown<FamilyMemberRelation>(
                  header: l10n?.relation ?? '',
                  hintText: l10n?.selectRelation ?? '',
                  items: cubit.relations(context),
                  value: state.relation,
                  itemAsString: (value) =>
                      FamilyMemberRelation.getString(context, value),
                  onChanged: cubit.onRelationChanged,
                  error: state.relationError,
                ),
                14.h.spaceVertical,
                Row(
                  children: [
                    Expanded(
                      child: Text(l10n?.vehicleNo ?? '', style: styleW500S14),
                    ),
                    GestureDetector(
                      onTap: cubit.onAddVehicle,
                      child: Text(
                        l10n?.addVehicle ?? '',
                        style: styleW500S14.copyWith(color: AppColors.orange),
                      ),
                    ),
                  ],
                ),
                10.h.spaceVertical,
                ...List.generate(state.vehicleFieldCount, (index) {
                  final canDelete = state.vehicleFieldCount > 1 && index > 0;

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < state.vehicleFieldCount - 1 ? 14.h : 0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: cubit.vehicleControllers[index],
                            hintText: l10n?.enterVehicleNumber ?? '',
                          ),
                        ),
                        if (canDelete) ...[
                          8.w.spaceHorizontal,
                          CustomIconButton(
                            icon: AppAssets.delete,
                            buttonColor: AppColors.red,
                            size: 22.h,
                            padding: 8.w,
                            onTap: () => cubit.onRemoveVehicle(index),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
