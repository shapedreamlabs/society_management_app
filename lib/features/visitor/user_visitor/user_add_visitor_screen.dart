import 'package:society_managment/society_managment.dart';

class UserAddVisitorScreen extends StatelessWidget {
  const UserAddVisitorScreen({super.key});

  static const routeName = '/user_add_visitor';

  static Widget builder(BuildContext context) {
    return BlocProvider<UserAddVisitorCubit>(
      create: (_) => UserAddVisitorCubit(),
      child: const UserAddVisitorScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<UserAddVisitorCubit, UserAddVisitorState>(
      builder: (context, state) {
        final cubit = context.read<UserAddVisitorCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.upcomingVisitorBooking ?? '',
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
              title: l10n?.submit ?? '',
              isLoading: state.loader,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _UserVisitorAvatar(state: state),

                    // Space
                    12.w.spaceHorizontal,

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n?.visitorPicture ?? '', style: styleW500S14),

                          // Space
                          10.h.spaceVertical,

                          Row(
                            children: [
                              Expanded(
                                child: _OutlineActionButton(
                                  label: l10n?.uploadImage ?? '',
                                  iconPath: AppAssets.upload,
                                  iconColor: AppColors.text,
                                  textColor: AppColors.text,
                                  onTap: () => cubit.onUploadImage(context),
                                ),
                              ),

                              // Space
                              8.w.spaceHorizontal,

                              Expanded(
                                child: _OutlineActionButton(
                                  label: l10n?.remove ?? '',
                                  iconPath: AppAssets.delete,
                                  iconColor: AppColors.logoutRed,
                                  textColor: AppColors.logoutRed,
                                  onTap: state.hasCustomImage
                                      ? cubit.onRemoveImage
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Space
                20.h.spaceVertical,

                AppTextField(
                  controller: cubit.nameController,
                  header: l10n?.visitorName ?? '',
                  hintText: l10n?.enterVisitorName ?? '',
                  error: state.nameError,
                ),

                // Space
                14.h.spaceVertical,

                AppTextField(
                  controller: cubit.phoneController,
                  header: l10n?.phoneNumber ?? '',
                  hintText: l10n?.enterPhoneNumber ?? '',
                  textInputType: TextInputType.phone,
                  error: state.phoneError,
                ),

                // Space
                14.h.spaceVertical,

                AppTextField(
                  header: l10n?.date ?? '',
                  hintText: state.visitDate.isEmpty
                      ? (l10n?.selectDate ?? '')
                      : state.visitDate,
                  suffixIcon: AppAssets.calender,
                  readOnly: true,
                  onTap: () => cubit.pickVisitDate(context),
                  error: state.dateError,
                ),

                // Space
                14.h.spaceVertical,

                AppTextField(
                  header: l10n?.time ?? '',
                  hintText: state.visitTime.isEmpty
                      ? (l10n?.selectTime ?? '')
                      : state.visitTime,
                  suffixIcon: AppAssets.clock,
                  readOnly: true,
                  onTap: () => cubit.pickVisitTime(context),
                  error: state.timeError,
                ),

                // Space
                14.h.spaceVertical,

                AppDropDown<String>(
                  header: l10n?.purpose ?? '',
                  hintText: l10n?.selectPurpose ?? '',
                  items: cubit.purposes,
                  value: state.purpose,
                  itemAsString: (value) => LocalizationLabels.of(l10n, value),
                  onChanged: cubit.onPurposeChanged,
                  error: state.purposeError,
                ),

                // Space
                14.h.spaceVertical,

                AppTextField(
                  controller: cubit.vehicleController,
                  header: l10n?.vehicleNo ?? '',
                  hintText: l10n?.enterVehicleNumber ?? '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UserVisitorAvatar extends StatelessWidget {
  const _UserVisitorAvatar({required this.state});

  final UserAddVisitorState state;

  @override
  Widget build(BuildContext context) {
    if (state.visitorImage != null) {
      return ClipOval(
        child: FileImg(
          state.visitorImage,
          width: 80.w,
          height: 80.w,
          fit: BoxFit.cover,
          borderRadius: 500.r,
          errorWidget: _placeholderAvatar(),
        ),
      );
    }

    return _placeholderAvatar();
  }

  Widget _placeholderAvatar() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: AppColors.text.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SvgAsset(
        imagePath: AppAssets.profile,
        height: 36.h,
        color: AppColors.text.withValues(alpha: 0.25),
      ),
    );
  }
}

class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({
    required this.label,
    required this.iconPath,
    required this.iconColor,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final String iconPath;
  final Color iconColor;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.text.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgAsset(
                imagePath: iconPath,
                height: 16.h,
                color: onTap == null
                    ? iconColor.withValues(alpha: 0.4)
                    : iconColor,
              ),

              // Space
              4.w.spaceHorizontal,

              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styleW500S12.copyWith(
                    color: onTap == null
                        ? textColor.withValues(alpha: 0.4)
                        : textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
