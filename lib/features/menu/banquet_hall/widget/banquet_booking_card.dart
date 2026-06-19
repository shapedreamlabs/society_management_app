import 'package:society_managment/society_management.dart';

class BanquetBookingCard extends StatelessWidget {
  const BanquetBookingCard({
    super.key,
    required this.name,
    required this.flat,
    required this.phone,
    required this.status,
    required this.date,
    required this.time,
    required this.purpose,
    required this.completedLabel,
    required this.pendingLabel,
    required this.dateLabel,
    required this.timeLabel,
    required this.purposeLabel,
  });

  final String name;
  final String flat;
  final String phone;
  final String status;
  final String date;
  final String time;
  final String purpose;
  final String completedLabel;
  final String pendingLabel;
  final String dateLabel;
  final String timeLabel;
  final String purposeLabel;

  bool get _isCompleted => status == 'completed';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: AssetsImg(
                  imagePath: AppAssets.defaultProfileImg,
                  fit: BoxFit.cover,
                  height: 44.w,
                  width: 44.w,
                ),
              ),
              10.w.spaceHorizontal,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$name - $flat', style: styleW600S16),
                    4.h.spaceVertical,
                    Text(
                      phone,
                      style: styleW400S14.copyWith(
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: (_isCompleted ? AppColors.orange : AppColors.red)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _isCompleted ? completedLabel : pendingLabel,
                  style: styleW500S12.copyWith(
                    color: _isCompleted ? AppColors.orange : AppColors.darkRed,
                  ),
                ),
              ),
            ],
          ),
          12.h.spaceVertical,
          Row(
            children: [
              Expanded(
                child: _DetailColumn(label: dateLabel, value: date),
              ),
              Expanded(
                child: _DetailColumn(label: timeLabel, value: time),
              ),
              Expanded(
                child: _DetailColumn(label: purposeLabel, value: purpose),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailColumn extends StatelessWidget {
  const _DetailColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: styleW400S12.copyWith(
            color: AppColors.text.withValues(alpha: 0.5),
          ),
        ),

        4.h.spaceVertical,

        Text(value, style: styleW500S14),
      ],
    );
  }
}
