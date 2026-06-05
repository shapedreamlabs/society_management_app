import 'package:society_managment/society_managment.dart';

class SocietyOverview extends StatelessWidget {
  const SocietyOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Society Overview', style: styleW500S20),
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: CommonOverviewCard(
                imagePath: AppAssets.buildingImg,
                value: '250',
                title: 'Total Flats',
              ),
            ),
            Expanded(
              child: CommonOverviewCard(
                imagePath: AppAssets.residentImg,
                value: '958',
                title: 'Total Residents',
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
                title: 'Total Complains',
              ),
            ),

            Expanded(
              child: CommonOverviewCard(
                imagePath: AppAssets.moneyBagImg,
                value: '2.4 L',
                title: 'Total Balance',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
