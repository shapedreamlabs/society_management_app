import 'package:society_managment/society_managment.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  static const routeName = '/my_profile';

  static Widget builder(BuildContext context) {
    return BlocProvider<MyProfileCubit>(
      create: (_) => MyProfileCubit(),
      child: const MyProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<MyProfileCubit, MyProfileState>(
      builder: (context, state) {
        final cubit = context.read<MyProfileCubit>();
        final profileImage = userModel?.image ?? '';

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.myProfile ?? '',
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
              title: l10n?.edit ?? '',
              onTap: () => cubit.onTapEdit(context),
            ),
          ),
          body: CustomSingleChildScroll(
            padding: EdgeInsets.all(16.h),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50.h),
                  margin: EdgeInsets.only(top: 50.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.text.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Column(
                    children: [
                      _detailRow(
                        label: l10n?.name ?? '',
                        value: userModel?.name ?? '-',
                      ),
                      _detailRow(
                        label: l10n?.phoneNumber ?? '',
                        value: userModel?.phone ?? '-',
                      ),
                      _detailRow(
                        label: l10n?.wingFlatNumber ?? '',
                        value: userModel?.address ?? '-',
                      ),
                      _detailRow(
                        label: l10n?.occupation ?? '',
                        value: userModel?.occupation ?? '-',
                      ),
                      _detailRow(label: l10n?.familyMember ?? '', value: '-'),
                      _detailRow(label: l10n?.moveInDate ?? '', value: '-'),
                      _detailRow(label: l10n?.vehicleNo ?? '', value: '-'),
                      _detailRow(
                        label: l10n?.status ?? '',
                        value: l10n?.active ?? '-',
                      ),
                      _detailRow(
                        label: l10n?.residentType ?? '',
                        value: l10n?.owner ?? '-',
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -10,
                  child: Container(
                    width: 116.w,
                    height: 116.w,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: profileImage.isNotEmpty
                          ? CachedImage(
                              userModel?.image,
                              skipBaseUrl: true,
                              width: 116.w,
                              height: 116.w,
                              fit: BoxFit.cover,
                            )
                          : AssetsImg(
                              imagePath: AppAssets.defaultProfileImg,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow({
    required String label,
    required String value,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: styleW400S16.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
              ),
              Text(value, style: styleW500S16),
            ],
          ),
        ),
        if (showDivider)
          CommonDivider(
            color: AppColors.text.withValues(alpha: 0.1),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
          ),
      ],
    );
  }
}
