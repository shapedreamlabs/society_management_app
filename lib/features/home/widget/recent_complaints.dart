import 'package:society_managment/society_managment.dart';

class RecentComplaints extends StatelessWidget {
  const RecentComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Complaints", style: styleW500S20),

            Text(
              "View All",
              style: styleW400S16.copyWith(
                color: AppColors.text.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),

        Container(
          padding: .symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
          ),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            separatorBuilder: (context, index) {
              return Container(
                height: 1.h,
                width: 100.w,
                color: AppColors.text.withValues(alpha: 0.1),
                margin: .symmetric(horizontal: 14.w, vertical: 12.h),
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipOval(
                  child: AssetsImg(
                    imagePath: AppAssets.defaultProfileImg,
                    fit: .cover,
                    height: 48.w,
                    width: 48.w,
                  ),
                ),

                title: Text("Water Leakage – A-403", style: styleW500S16),

                subtitle: Text(
                  "Suresh Patel • 2 hrs ago",
                  style: styleW500S16.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),

                trailing: Container(
                  width: 60.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: AppColors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Urgent",
                    style: styleW500S12.copyWith(color: AppColors.darkRed),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
