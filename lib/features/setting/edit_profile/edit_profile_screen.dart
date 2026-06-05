import 'package:society_managment/society_managment.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  static const routeName = '/edit_profile';

  static Widget builder(BuildContext context) {
    final data = context.args as Map<String, dynamic>?;
    return BlocProvider<EditProfileCubit>(
      create: (_) => EditProfileCubit(data),
      child: const EditProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.editProfile ?? '',
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
              title: l10n?.save ?? '',
              isLoading: state.loader,
              onTap: () => cubit.onTapSave(context),
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
                Center(
                  child: InkWell(
                    onTap: () => cubit.onChangeProfile(context),
                    borderRadius: BorderRadius.circular(500.r),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildProfileAvatar(state),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500.r),
                              color: AppColors.text,
                              border: Border.all(
                                width: 2.w,
                                color: AppColors.white,
                              ),
                            ),
                            child: Center(
                              child: SvgAsset(
                                imagePath: AppAssets.edit,
                                height: 16.h,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                24.h.spaceVertical,
                AppTextField(
                  controller: cubit.nameController,
                  header: l10n?.name ?? '',
                  hintText: l10n?.enterName ?? '',
                  error: state.nameError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  controller: cubit.phoneNumberController,
                  header: l10n?.phoneNumber ?? '',
                  hintText: l10n?.enterPhoneNumber ?? '',
                  textInputType: TextInputType.phone,
                  error: state.phoneNumberError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.wing ?? '',
                  hintText: l10n?.selectWing ?? '',
                  items: cubit.wings,
                  value: state.wing,
                  itemAsString: (value) => value,
                  onChanged: cubit.onWingChanged,
                  error: state.wingError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.flat ?? '',
                  hintText: l10n?.selectFlat ?? '',
                  items: cubit.flats,
                  value: state.flat,
                  itemAsString: (value) => value,
                  onChanged: cubit.onFlatChanged,
                  error: state.flatError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  controller: cubit.occupationController,
                  header: l10n?.occupation ?? '',
                  hintText: l10n?.enterOccupation ?? '',
                  error: state.occupationError,
                ),
                14.h.spaceVertical,
                AppTextField(
                  header: l10n?.moveInDate ?? '',
                  hintText: state.moveInDate.isEmpty
                      ? (l10n?.selectDate ?? '')
                      : state.moveInDate,
                  suffixIcon: AppAssets.calender,
                  readOnly: true,
                  onTap: () => cubit.pickMoveInDate(context),
                  error: state.moveInDateError,
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
                            hintText: l10n?.enterVehicleNo ?? '',
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
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.residentType ?? '',
                  hintText: l10n?.selectResidentType ?? '',
                  items: cubit.residentTypes,
                  value: state.residentType,
                  itemAsString: (value) => LocalizationLabels.of(l10n, value),
                  onChanged: cubit.onResidentTypeChanged,
                  error: state.residentTypeError,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileAvatar(EditProfileState state) {
    if (state.profileImage != null) {
      return FileImg(
        state.profileImage,
        height: 116.h,
        width: 116.h,
        fit: BoxFit.cover,
        borderRadius: 500.r,
        errorWidget: Padding(
          padding: EdgeInsets.all(20.w),
          child: AssetsImg(
            imagePath: AppAssets.defaultProfileImg,
            height: 50.w,
            width: 50.w,
            borderRadius: 500.r,
          ),
        ),
      );
    }

    if ((state.profileImageUrl ?? '').isNotEmpty) {
      return CachedImage(
        state.profileImageUrl,
        skipBaseUrl: true,
        height: 116.h,
        width: 116.h,
        fit: BoxFit.cover,
        borderRadius: 500.r,
      );
    }

    return AssetsImg(
      imagePath: AppAssets.defaultProfileImg,
      height: 116.h,
      width: 116.h,
      fit: BoxFit.cover,
      borderRadius: 500.r,
    );
  }
}
