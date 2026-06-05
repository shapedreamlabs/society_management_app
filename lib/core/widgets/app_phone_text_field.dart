import 'package:society_managment/society_managment.dart';

class AppPhoneTextField extends StatelessWidget {
  const AppPhoneTextField({
    super.key,
    this.header,
    this.hintText,
    this.controller,
    this.error,
    this.countryCode = CountryCodes.defaultDialCode,
    this.onChanged,
    this.onCountryCodeChanged,
  });

  final String? header;
  final String? hintText;
  final String? error;
  final String countryCode;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final void Function(String dialCode)? onCountryCodeChanged;

  @override
  Widget build(BuildContext context) {
    final hasError = error?.isNotEmpty ?? false;
    final borderColor = hasError
        ? AppColors.red
        : AppColors.text.withValues(alpha: 0.1);
    final maxPhoneLength = CountryCodes.maxPhoneLengthFor(countryCode);

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        if (header?.isNotEmpty ?? false)
          Padding(
            padding: .only(bottom: 10.h),
            child: Text(header ?? "", style: styleW500S14),
          ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: .circular(8.r),
            border: Border.all(color: borderColor),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                CountryCodePicker(
                  key: ValueKey(countryCode),
                  onChanged: (code) {
                    final dialCode =
                        code.dialCode ?? CountryCodes.defaultDialCode;
                    if (dialCode != countryCode) {
                      onCountryCodeChanged?.call(dialCode);
                    }
                  },
                  initialSelection: countryCode,
                  favorite: const ['+91', 'IN'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  showFlag: true,
                  showDropDownButton: false,
                  padding: EdgeInsets.zero,
                  pickerStyle: PickerStyle.bottomSheet,
                  textStyle: styleW500S14,
                  builder: (country) {
                    return Padding(
                      padding: .symmetric(horizontal: 14.w, vertical: 12.h),
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          if (country?.flagUri != null)
                            Padding(
                              padding: .only(right: 8.w),
                              child: Image.asset(
                                country!.flagUri!,
                                package: 'country_code_picker',
                                width: 24.w,
                                height: 18.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Text(
                            country?.dialCode ?? countryCode,
                            style: styleW500S14,
                          ),
                          4.w.spaceHorizontal,
                          SvgAsset(
                            imagePath: AppAssets.downArrow,
                            height: 16.h,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: AppColors.text.withValues(alpha: 0.1),
                ),
                Expanded(
                  child: TextField(
                    style: styleW400S14,
                    controller: controller,
                    onTapOutside: (_) => hideKeyboard(context: context),
                    keyboardType: TextInputType.phone,
                    textInputAction: .done,
                    onChanged: onChanged,
                    maxLength: maxPhoneLength,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: '',
                      isDense: true,
                      hintText: hintText,
                      hintStyle: styleW400S14.copyWith(
                        color: hasError ? AppColors.red : AppColors.grey,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: .symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ErrorText(error: error, topPadding: 6.h),
      ],
    );
  }
}
