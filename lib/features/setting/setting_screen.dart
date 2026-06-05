import 'package:society_managment/society_managment.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const routeName = '/setting';

  static Widget builder(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (c) => SettingCubit(context),
      child: const SettingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            backArrow: false,
            color: AppColors.blue,
            centerTitle: false,
            systemUiStyle: .light,
            title: l10n?.setting ?? "",
            titleSpacing: 20.w,
            titleStyle: styleW700S24.copyWith(color: AppColors.white),
          ),
          body: Stack(
            alignment: .topCenter,
            children: [
              Container(
                color: AppColors.blue,
                width: 100.sw,
                height: 50.sh,
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    15.h.spaceVertical,

                    Container(
                      width: 115.h,
                      height: 115.h,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.6),
                        borderRadius: .circular(500.r),
                      ),
                      child: Center(
                        child: (state.avatar.isNotEmpty)
                            ? CachedImage(
                                state.avatar,
                                skipBaseUrl: true,
                                height: 114.h,
                                width: 114.h,
                                fit: .cover,
                                borderRadius: 500.r,
                              )
                            : AssetsImg(
                                imagePath: AppAssets.defaultProfileImg,
                                height: 114.h,
                                width: 114.h,
                                borderRadius: 500.r,
                              ),
                      ),
                    ),

                    15.h.spaceVertical,

                    Text(
                      state.name.isNotEmpty ? state.name : "User",
                      style: styleW600S20.copyWith(color: AppColors.white),
                    ),

                    8.h.spaceVertical,

                    Text(
                      state.phone.isNotEmpty ? state.phone : '-',
                      style: styleW400S16.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: .bottomCenter,
                child: DraggableScrollableSheet(
                  minChildSize: 0.66,
                  initialChildSize: 0.66,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: .vertical(top: .circular(20.r)),
                      ),
                      child: SingleChildScrollView(
                        child: CustomListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.settings.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: .symmetric(
                              horizontal: AppConstants.horizontalPadding,
                            ),
                            child: CommonDivider(
                              color: AppColors.text.withValues(alpha: 0.1),
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final setting = state.settings[index];

                            return SettingItemWidget(
                              isFirst: index == 0,
                              isLast: index == state.settings.length - 1,
                              title: setting.title ?? "",
                              icon: setting.icon ?? "",
                              onTap: setting.onTap,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final bool isFirst;
  final bool isLast;
  final String title;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgColor,
      borderRadius: isFirst ? .vertical(top: .circular(20.r)) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: isFirst ? .vertical(top: .circular(20.r)) : null,
        child: Container(
          padding: .symmetric(
            vertical: 20.h,
            horizontal: AppConstants.horizontalPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: isFirst ? .vertical(top: .circular(20.r)) : null,
          ),
          child: Row(
            spacing: 12.w,
            children: [
              SvgAsset(
                imagePath: icon,
                height: 24.h,
                color: isLast ? AppColors.logoutRed : AppColors.text,
              ),

              Expanded(
                child: Text(
                  title,
                  style: styleW500S16.copyWith(
                    color: isLast ? AppColors.logoutRed : AppColors.text,
                  ),
                ),
              ),

              if (!isLast)
                RotatedBox(
                  quarterTurns: 3,
                  child: SvgAsset(imagePath: AppAssets.downArrow, height: 16.h),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
