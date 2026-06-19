import 'package:society_managment/society_management.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (c) => HomeCubit(),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: CustomSingleChildScroll(
              padding: .all(20.h),
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: .symmetric(horizontal: 14.w, vertical: 12.w),
                    width: 100.sw,
                    decoration: BoxDecoration(
                      color: AppColors.red.withValues(alpha: 0.1),
                      borderRadius: .circular(10.r),
                      border: Border.all(
                        color: AppColors.red.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.fireDrillTodayTitle ?? '',
                              style: styleW600S16.copyWith(
                                color: AppColors.red,
                              ),
                            ),
                            8.h.spaceVertical,
                            Text(
                              l10n?.fireDrillTodaySubtitle ?? '',
                              style: styleW400S12.copyWith(
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgAsset(imagePath: AppAssets.forwardArrow),
                      ],
                    ),
                  ),
                  SocietyOverview(l10n: l10n),
                  RecentComplaints(l10n: l10n),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
