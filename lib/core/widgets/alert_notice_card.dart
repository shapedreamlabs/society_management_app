import 'package:society_managment/society_managment.dart';

class AlertNoticeCard extends StatelessWidget {
  const AlertNoticeCard({
    super.key,
    required this.title,
    required this.description,
    required this.metaLeft,
    required this.metaRight,
  });

  final String title;
  final String description;
  final String metaLeft;
  final String metaRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: .all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: styleW600S16),

          4.h.spaceVertical,

          Text(
            description,
            style: styleW400S14.copyWith(
              color: AppColors.text.withValues(alpha: 0.6),
              height: 1.4,
            ),
          ),

          6.h.spaceVertical,

          Row(
            children: [
              Expanded(
                child: Text(
                  metaLeft,
                  style: styleW400S12.copyWith(
                    color: AppColors.text.withValues(alpha: 0.8),
                  ),
                ),
              ),
              Text(
                metaRight,
                style: styleW400S12.copyWith(
                  color: AppColors.text.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
