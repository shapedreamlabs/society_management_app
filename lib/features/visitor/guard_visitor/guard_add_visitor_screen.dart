import 'package:society_managment/society_managment.dart';

class GuardAddVisitorScreen extends StatelessWidget {
  const GuardAddVisitorScreen({super.key});

  static const routeName = '/guard_add_visitor';

  static Widget builder(BuildContext context) {
    return BlocProvider<GuardAddVisitorCubit>(
      create: (_) => GuardAddVisitorCubit(),
      child: const GuardAddVisitorScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<GuardAddVisitorCubit, GuardAddVisitorState>(
      builder: (context, state) {
        final cubit = context.read<GuardAddVisitorCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.addVisitor ?? '',
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
                Text(l10n?.visitorPicture ?? '', style: styleW500S14),
                10.h.spaceVertical,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _GuardVisitorAvatar(state: state),
                    12.w.spaceHorizontal,
                    Expanded(
                      child: Row(
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
                    ),
                  ],
                ),
                20.h.spaceVertical,
                AppTextField(
                  controller: cubit.nameController,
                  header: l10n?.visitorName ?? '',
                  hintText: l10n?.enterVisitorName ?? '',
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
                  header: l10n?.visitingWing ?? '',
                  hintText: l10n?.selectVisitingWing ?? '',
                  items: cubit.wings,
                  value: state.wing,
                  itemAsString: (value) => cubit.wingLabel(context, value),
                  onChanged: cubit.onWingChanged,
                  error: state.wingError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.visitingFlat ?? '',
                  hintText: l10n?.selectVisitingFlat ?? '',
                  items: cubit.flats,
                  value: state.flat,
                  itemAsString: (value) => value,
                  onChanged: cubit.onFlatChanged,
                  error: state.flatError,
                ),
                14.h.spaceVertical,
                AppDropDown<String>(
                  header: l10n?.purpose ?? '',
                  hintText: l10n?.selectPurpose ?? '',
                  items: cubit.purposes,
                  value: state.purpose,
                  itemAsString: (value) => value,
                  onChanged: cubit.onPurposeChanged,
                  error: state.purposeError,
                ),
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

class _GuardVisitorAvatar extends StatelessWidget {
  const _GuardVisitorAvatar({required this.state});

  final GuardAddVisitorState state;

  @override
  Widget build(BuildContext context) {
    if (state.visitorImage != null) {
      return ClipOval(
        child: FileImg(
          state.visitorImage,
          width: 64.w,
          height: 64.w,
          fit: BoxFit.cover,
          borderRadius: 500.r,
          errorWidget: _defaultAvatar(),
        ),
      );
    }

    return _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return ClipOval(
      child: AssetsImg(
        imagePath: AppAssets.defaultProfileImg,
        width: 64.w,
        height: 64.w,
        fit: BoxFit.cover,
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
