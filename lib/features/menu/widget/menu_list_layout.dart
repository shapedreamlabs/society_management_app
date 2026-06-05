import 'package:society_managment/society_managment.dart';

class MenuListLayout extends StatelessWidget {
  const MenuListLayout({super.key, required this.items, this.onItemTap});

  final List<MenuItemModel> items;
  final void Function(MenuItemModel item, int index)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MenuListHeader(),
        Expanded(
          child: ListView.separated(
            padding: .all(AppConstants.horizontalPadding),
            itemCount: items.length,
            separatorBuilder: (_, _) => 12.h.spaceVertical,
            itemBuilder: (context, index) {
              final item = items[index];
              return _MenuListTile(
                item: item,
                onTap: onItemTap == null
                    ? null
                    : () => onItemTap!(item, index),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MenuListHeader extends StatelessWidget {
  const _MenuListHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.blue,
      padding: .fromLTRB(
        AppConstants.horizontalPadding,
        MediaQuery.of(context).padding.top + 16.h,
        AppConstants.horizontalPadding,
        24.h,
      ),
      child: Row(
        spacing: 12.w,
        children: [
          ClipOval(
            child: (userModel?.image ?? "").isNotEmpty
                ? CachedImage(
                    userModel?.image,
                    skipBaseUrl: true,
                    fit: .cover,
                    height: 56.w,
                    width: 56.w,
                  )
                : AssetsImg(
                    imagePath: AppAssets.defaultProfileImg,
                    fit: .cover,
                    height: 56.w,
                    width: 56.w,
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizationLabels.greeting(context.l10n),
                  style: styleW400S14.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
                4.h.spaceVertical,
                Text(
                  userModel?.name ?? (context.l10n?.notAvailable ?? ''),
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: styleW600S20.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuListTile extends StatelessWidget {
  const _MenuListTile({required this.item, this.onTap});

  final MenuItemModel item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: .circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(8.r),
        child: Container(
          padding: .symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.grey1.withValues(alpha: 0.04),
            borderRadius: .circular(8.r),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgAsset(imagePath: item.iconPath, height: 22.h),
                ),
              ),
              14.w.spaceHorizontal,
              Expanded(child: Text(item.title, style: styleW500S16)),
              SvgAsset(
                imagePath: AppAssets.forwardArrow,
                height: 20.h,
                color: AppColors.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
