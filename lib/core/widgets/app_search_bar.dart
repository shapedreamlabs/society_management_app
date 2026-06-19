import 'package:society_managment/society_management.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: styleW400S16,
      controller: controller,
      onTapOutside: (e) => hideKeyboard(context: context),
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: styleW400S16.copyWith(
          color: AppColors.text.withValues(alpha: 0.6),
        ),
        isCollapsed: true,
        contentPadding: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
          top: 12.h,
          bottom: 12.h,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: AppInputBorders.outline(radius: 12.r),
        focusedBorder: AppInputBorders.outline(radius: 12.r, isFocused: true),
        disabledBorder: AppInputBorders.outline(radius: 12.r, isDisabled: true),
        errorBorder: AppInputBorders.outline(radius: 12.r, hasError: true),
        focusedErrorBorder: AppInputBorders.outline(
          radius: 12.r,
          hasError: true,
          isFocused: true,
        ),
        enabledBorder: AppInputBorders.outline(radius: 12.r),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 10.w),
          child: SvgAsset(imagePath: AppAssets.search, width: 20.w),
        ),
        prefixIconConstraints: BoxConstraints(maxWidth: 45.w, maxHeight: 45.w),
      ),
    );
  }
}
