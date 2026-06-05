import 'package:society_managment/society_managment.dart';

class CommonDashAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonDashAppBar({super.key, this.showSearchBar = false});

  final bool showSearchBar;

  static double get _searchBottomHeight => 60.h;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + 8.h + (showSearchBar ? _searchBottomHeight : 0),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomAppBar(
      color: Colors.transparent,
      backArrow: false,
      centerTitle: false,
      flexibleSpaceWidget: Container(
        decoration: const BoxDecoration(
          color: AppColors.blue,
          image: DecorationImage(
            image: AssetImage(AppAssets.grillImg),
            fit: BoxFit.cover,
          ),
        ),
      ),

      titleWidget: const _UserWidget(),
      titleSpacing: 20.w,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: AppConstants.horizontalPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _HomeAppBarIcon(icon: AppAssets.emergencyAlert, onTap: () {}),
              SizedBox(width: 10.w),
              _HomeAppBarIcon(
                icon: AppAssets.menu,
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
            ],
          ),
        ),
      ],
      bottom: showSearchBar
          ? PreferredSize(
              preferredSize: Size.fromHeight(_searchBottomHeight),
              child: Padding(
                padding: .fromLTRB(
                  AppConstants.horizontalPadding,
                  0,
                  AppConstants.horizontalPadding,
                  12.h,
                ),
                child: AppSearchBar(
                  hintText: l10n?.dashboardSearchHint ?? "",
                  onChanged: (_) {},
                ),
              ),
            )
          : null,
    );
  }
}

class _UserWidget extends StatelessWidget {
  const _UserWidget();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      spacing: 10.w,
      children: [
        ClipOval(
          child: (userModel?.image ?? "").isNotEmpty
              ? CachedImage(
                  userModel?.image,
                  skipBaseUrl: true,
                  fit: .cover,
                  height: 48.w,
                  width: 48.w,
                )
              : AssetsImg(
                  imagePath: AppAssets.defaultProfileImg,
                  fit: .cover,
                  height: 48.w,
                  width: 48.w,
                ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .start,
            spacing: 2.h,
            children: [
              Text(
                LocalizationLabels.greeting(l10n),
                maxLines: 1,
                overflow: .ellipsis,
                style: styleW400S16.copyWith(
                  color: AppColors.white.withValues(alpha: 0.8),
                ),
              ),
              Text(
                userModel?.name ?? (l10n?.notAvailable ?? ''),
                maxLines: 1,
                overflow: .ellipsis,
                style: styleW500S18.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeAppBarIcon extends StatelessWidget {
  const _HomeAppBarIcon({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: .circular(500.r),
      color: AppColors.blue,
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(500.r),
        child: Padding(
          padding: .all(10.w),
          child: SvgAsset(imagePath: icon, height: 24.h),
        ),
      ),
    );
  }
}
