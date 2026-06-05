import 'package:society_managment/society_managment.dart';

class ResidentDetailsScreen extends StatelessWidget {
  const ResidentDetailsScreen({super.key, required this.resident});

  static const routeName = '/resident_details';

  final Map<String, String> resident;

  static Widget builder(BuildContext context) {
    final args = context.args;
    final resident = args is Map<String, String> ? args : <String, String>{};
    return ResidentDetailsScreen(resident: resident);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final residentPhoneNo = resident['mobile'] ?? '';
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.details ?? '',
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
          title: l10n?.contactResident ?? '',
          onTap: () => _openDialer(context, residentPhoneNo),
        ),
      ),
      body: CustomSingleChildScroll(
        padding: EdgeInsets.all(16.h),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: .only(top: 50.h),
              margin: .only(top: 50.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.text.withValues(alpha: 0.05),
                ),
              ),
              child: Column(
                children: [
                  detailRow(
                    label: l10n?.name ?? '',
                    value: resident['name'] ?? '-',
                  ),
                  detailRow(
                    label: l10n?.phoneNumber ?? '',
                    value: resident['mobile'] ?? '-',
                  ),
                  detailRow(
                    label: l10n?.wingFlatNumber ?? '',
                    value:
                        resident['wingFlatNumber'] ?? resident['flat'] ?? '-',
                  ),
                  detailRow(
                    label: l10n?.occupation ?? '',
                    value: resident['profession'] ?? '-',
                  ),
                  detailRow(
                    label: l10n?.familyMember ?? '',
                    value:
                        '${resident['members'] ?? '-'} ${l10n?.member ?? ''}',
                  ),
                  detailRow(
                    label: l10n?.moveInDate ?? '',
                    value: resident['moveInDate'] ?? '-',
                  ),
                  detailRow(
                    label: l10n?.vehicleNo ?? '',
                    value: resident['vehicleNo'] ?? resident['vehicle'] ?? '-',
                  ),
                  detailRow(
                    label: l10n?.status ?? '',
                    value: LocalizationLabels.of(
                      l10n,
                      (resident['status'] ?? AppLabelKeys.active)
                          .toString()
                          .toLowerCase(),
                    ),
                  ),
                  detailRow(
                    label: l10n?.residentType ?? '',
                    value: LocalizationLabels.of(
                      l10n,
                      (resident['residentType'] ?? AppLabelKeys.owner)
                          .toString()
                          .toLowerCase(),
                    ),
                    showDivider: false,
                  ),
                ],
              ),
            ),

            Positioned(
              top: -10,
              child: Container(
                width: 116.w,
                height: 116.w,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: AssetsImg(
                    imagePath: AppAssets.defaultProfileImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow({
    required String label,
    required String value,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: styleW400S16.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
              ),
              Text(value, style: styleW500S16),
            ],
          ),
        ),
        if (showDivider)
          CommonDivider(
            color: AppColors.text.withValues(alpha: 0.1),
            margin: .symmetric(horizontal: 16.w),
          ),
      ],
    );
  }

  Future<void> _openDialer(BuildContext context, String phoneNo) async {
    final normalizedPhoneNo = phoneNo.replaceAll(RegExp(r'[^\d+]'), '');
    if (normalizedPhoneNo.isEmpty) return;

    final dialUri = Uri(scheme: 'tel', path: normalizedPhoneNo);
    final launched = await launchUrl(
      dialUri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n?.somethingWentWrong ?? '')),
      );
    }
  }
}
