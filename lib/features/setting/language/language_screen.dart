import 'package:society_managment/society_managment.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  static const routeName = '/language';

  static Widget builder(BuildContext context) {
    final currentLocale = context.read<AppCubit>().state.locale;

    return BlocProvider<LanguageCubit>(
      create: (_) => LanguageCubit(initialLocale: currentLocale),
      child: const LanguageScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final cubit = context.read<LanguageCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomAppBar(
            title: l10n?.language ?? '',
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
              title: l10n?.save ?? '',
              isLoading: state.loader,
              isDisabled: !state.hasLanguageChanged,
              onTap: () => cubit.updateLanguage(context),
            ),
          ),
          body: ListView.separated(
            padding: EdgeInsets.fromLTRB(
              AppConstants.horizontalPadding,
              12.h,
              AppConstants.horizontalPadding,
              16.h,
            ),
            itemCount: state.languages.length,
            separatorBuilder: (_, _) => 12.h.spaceVertical,
            itemBuilder: (context, index) {
              final lang = state.languages[index];
              return LanguageItemWidget(
                lang: lang,
                isSelected: lang.code == state.selectedLanguage?.code,
                onTap: () => cubit.selectLanguage(lang),
              );
            },
          ),
        );
      },
    );
  }
}

class LanguageItemWidget extends StatelessWidget {
  const LanguageItemWidget({
    super.key,
    required this.lang,
    required this.isSelected,
    required this.onTap,
  });

  final LanguageModel lang;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  LocalizationLabels.languageLabel(context.l10n, lang.code),
                  style: styleW500S16,
                ),
              ),
              if (isSelected)
                Container(
                  height: 22.w,
                  width: 22.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.orange, width: 2),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.orange,
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
