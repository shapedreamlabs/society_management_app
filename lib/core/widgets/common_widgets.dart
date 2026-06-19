import 'package:society_managment/society_management.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    this.error,
    this.topPadding = 0,
    this.isCenterAlign = false,
  });

  final String? error;
  final double topPadding;
  final bool isCenterAlign;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Padding(
        padding: .only(top: topPadding),
        child: Row(
          spacing: 4.w,
          mainAxisAlignment: isCenterAlign ? .center : .start,
          children: [
            SvgAsset(imagePath: AppAssets.error, height: 16.h),
            Flexible(
              fit: isCenterAlign ? .loose : .tight,
              child: Align(
                alignment: .centerLeft,
                child: AnimatedSwitcher(
                  duration: 300.milliseconds,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          alignment: .centerLeft,
                          child: child,
                        );
                      },
                  child: Text(
                    error ?? '',
                    key: ValueKey<String>(error ?? ""),
                    style: styleW500S12.copyWith(color: AppColors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: SizedBox.shrink(),
      alignment: .center,
      sizeCurve: Curves.bounceOut,
      firstCurve: Curves.bounceOut,
      secondCurve: Curves.bounceOut,
      crossFadeState: (error ?? '').isNotEmpty ? .showFirst : .showSecond,
      duration: 300.milliseconds,
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: .srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key, this.height, this.color, this.margin});

  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1.h,
      width: .infinity,
      color: color ?? AppColors.black.withValues(alpha: 0.1),
      margin: margin ?? .zero,
    );
  }
}

class CommonOverviewCard extends StatelessWidget {
  const CommonOverviewCard({
    super.key,
    required this.imagePath,
    required this.value,
    required this.title,
    this.imageHeight,
    this.imageWidth,
    this.borderRadius,
  });

  final String imagePath;
  final String value;
  final String title;
  final double? imageHeight;
  final double? imageWidth;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AssetsImg(
            imagePath: imagePath,
            height: imageHeight ?? 40.h,
            width: imageWidth ?? 40.h,
          ),
          8.h.spaceVertical,
          Text(value, style: styleW600S18),
          2.h.spaceVertical,
          Text(
            title,
            style: styleW400S14.copyWith(
              color: AppColors.text.withValues(alpha: 0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
    return card;
  }
}

class CommonFilterChip extends StatelessWidget {
  const CommonFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.orange : AppColors.white,
      borderRadius: BorderRadius.circular(24.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            border: selected
                ? null
                : Border.all(color: AppColors.text.withValues(alpha: 0.1)),
          ),
          child: Text(
            label,
            style: styleW500S14.copyWith(
              color: selected
                  ? AppColors.white
                  : AppColors.text.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonFilterChipRow extends StatelessWidget {
  const CommonFilterChipRow({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.spacing,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: spacing ?? 8.w,
        children: List.generate(labels.length, (index) {
          return CommonFilterChip(
            label: labels[index],
            selected: selectedIndex == index,
            onTap: () => onSelected(index),
          );
        }),
      ),
    );
  }
}

class CommonFloatingActionButton extends StatelessWidget {
  const CommonFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.heroTag,
    this.backgroundColor = AppColors.orange,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Object? heroTag;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: AppColors.fabBoxShadow,
      ),
      child: FloatingActionButton(
        heroTag: heroTag,
        elevation: 0,
        highlightElevation: 0,
        splashColor: AppColors.white.withValues(alpha: 0.2),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500.r),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomShimmer({super.key, this.height, this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: Shimmer.fromColors(
        baseColor: AppColors.primary.withValues(alpha: 0.2),
        highlightColor: AppColors.primary.withValues(alpha: 0),
        child: Container(
          height: height ?? .maxFinite,
          width: width ?? .maxFinite,
          color: AppColors.black,
        ),
      ),
    );
  }
}
