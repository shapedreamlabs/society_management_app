import 'package:society_managment/society_managment.dart';

class SocietyOverview extends StatelessWidget {
  const SocietyOverview({super.key, required this.l10n});

  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n?.societyOverview ?? '', style: styleW500S20),
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: CommonOverviewCard(
                imagePath: AppAssets.buildingImg,
                value: '250',
                title: l10n?.totalFlats ?? '',
              ),
            ),
            Expanded(
              child: CommonOverviewCard(
                imagePath: AppAssets.residentImg,
                value: '958',
                title: l10n?.totalResidents ?? '',
              ),
            ),
          ],
        ),
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: CommonOverviewCard(
                imagePath: AppAssets.angryImg,
                value: '10',
                title: l10n?.totalComplaints ?? '',
              ),
            ),
            Expanded(
              child: CommonOverviewCard(
                imagePath: AppAssets.moneyBagImg,
                value: '2.4 L',
                title: l10n?.totalBalance ?? '',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
