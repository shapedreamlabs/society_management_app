import 'package:society_managment/society_management.dart';

abstract class AppInputBorders {
  static InputBorder outline({
    double? radius,
    bool hasError = false,
    bool isFocused = false,
    bool isDisabled = false,
  }) {
    if (isDisabled) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 8.r),
        borderSide: BorderSide(color: AppColors.inputDisabledBorder),
      );
    }

    if (hasError) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 8.r),
        borderSide: BorderSide(
          color: AppColors.inputErrorBorder,
          width: isFocused ? 1.5 : 1,
        ),
      );
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 8.r),
      borderSide: BorderSide(
        color: isFocused
            ? AppColors.inputFocusedBorder
            : AppColors.inputEnabledBorder,
        width: isFocused ? 1.5 : 1,
      ),
    );
  }
}
