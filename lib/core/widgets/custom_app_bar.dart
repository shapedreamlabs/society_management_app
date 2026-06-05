import 'package:society_managment/society_managment.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = "",
    this.actions,
    this.centerTitle = true,
    this.backArrow = true,
    this.appBarSize,
    this.bottomSize = 0,
    this.bottom,
    this.leading,
    this.color,
    this.titleStyle,
    this.onBackTap,
    this.leadingWidth,
    this.titleSpacing,
    this.titleWidget,
    this.flexibleSpaceWidget,
    this.systemUiStyle,
    this.backIconColor = AppColors.white,
  });

  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double bottomSize;
  final Widget? leading, titleWidget, flexibleSpaceWidget;
  final Color? color;
  final TextStyle? titleStyle;
  final void Function()? onBackTap;
  final bool centerTitle, backArrow;
  final double? appBarSize, leadingWidth, titleSpacing;
  final SystemUiOverlayStyle? systemUiStyle;
  final Color backIconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: systemUiStyle ?? .dark,
      leading: backArrow && leading == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: onBackTap ?? context.navigator.pop,
                borderRadius: BorderRadius.circular(50.r),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgAsset(
                    imagePath: AppAssets.backArrow,
                    color: backIconColor,
                  ),
                ),
              ),
            )
          : leading,
      leadingWidth: leadingWidth ?? 66.w,
      elevation: 0,
      backgroundColor: color ?? Colors.transparent,
      title:
          titleWidget ??
          (title.isEmpty
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Text(title, style: titleStyle ?? styleW700S24),
                )),
      centerTitle: centerTitle,
      actions: actions,
      titleSpacing: titleSpacing ?? 0.w,
      bottom: bottom,
      flexibleSpace: flexibleSpaceWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 8.h + bottomSize);
}
