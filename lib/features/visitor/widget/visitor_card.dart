import 'package:society_managment/society_managment.dart';

class VisitorCard extends StatelessWidget {
  const VisitorCard({
    super.key,
    required this.name,
    required this.flat,
    required this.date,
    required this.vehicleNo,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.approvedLabel,
    required this.rejectedLabel,
    required this.calledLabel,
    required this.vehicleNoLabel,
    required this.checkInLabel,
    required this.checkOutLabel,
    this.showCheckOutAction = false,
    this.onCheckOutTap,
    this.showTimeSection = true,
    this.bookedLabel = '',
  });

  final String name;
  final String flat;
  final String date;
  final String vehicleNo;
  final String checkIn;
  final String checkOut;
  final String status;
  final String approvedLabel;
  final String rejectedLabel;
  final String calledLabel;
  final String vehicleNoLabel;
  final String checkInLabel;
  final String checkOutLabel;
  final bool showCheckOutAction;
  final VoidCallback? onCheckOutTap;
  final bool showTimeSection;
  final String bookedLabel;

  bool get _showCheckOutButton =>
      showCheckOutAction &&
      status != 'rejected' &&
      checkOut.isEmpty &&
      onCheckOutTap != null;

  @override
  Widget build(BuildContext context) {
    final isRejected = status == 'rejected';
    final statusColor = _statusColor();
    final statusLabel = _statusLabel();
    final flatDate = [
      if (flat.isNotEmpty) flat,
      if (date.isNotEmpty) date,
    ].join(' · ');
    final displayCheckIn = isRejected
        ? '--:--'
        : (checkIn.isNotEmpty ? checkIn : '-');
    final displayCheckOut = isRejected
        ? '--:--'
        : (checkOut.isNotEmpty
            ? checkOut
            : (checkIn.isNotEmpty ? '--:--' : '-'));

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: AssetsImg(
                imagePath: AppAssets.defaultProfileImg,
                fit: BoxFit.cover,
                width: 40.w,
                height: 40.w,
              ),
            ),

            // Space
            10.w.spaceHorizontal,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: styleW600S16),

                  if (flatDate.isNotEmpty) ...[
                    // Space
                    2.h.spaceVertical,

                    Text(
                      flatDate,
                      style: styleW400S14.copyWith(
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                    ),
                  ],

                  if (vehicleNo.isNotEmpty) ...[
                    // Space
                    2.h.spaceVertical,

                    Text(
                      '$vehicleNoLabel: $vehicleNo',
                      style: styleW400S14.copyWith(
                        color: AppColors.text.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Space
            8.w.spaceHorizontal,

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                statusLabel,
                style: styleW500S12.copyWith(color: statusColor),
              ),
            ),
          ],
        ),

        if (showTimeSection) ...[
          // Space
          12.h.spaceVertical,

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: AppColors.text.withValues(alpha: 0.02),
              border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _TimeLogItem(
                      label: checkInLabel,
                      time: displayCheckIn,
                      isCheckIn: true,
                    ),
                  ),
                  VerticalDivider(color: AppColors.text.withValues(alpha: 0.1)),
                  Expanded(
                    child: _TimeLogItem(
                      label: checkOutLabel,
                      time: displayCheckOut,
                      isCheckIn: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

        if (_showCheckOutButton) ...[
          // Space
          12.h.spaceVertical,

          CustomButton(
            title: checkOutLabel,
            buttonColor: AppColors.logoutRed,
            onTap: onCheckOutTap!,
          ),
        ],
      ],
    );
  }

  Color _statusColor() {
    return switch (status) {
      'approved' => AppColors.chartIncomeGreen,
      'called' => AppColors.skyBlue,
      'booked' => AppColors.booked,
      _ => AppColors.logoutRed,
    };
  }

  String _statusLabel() {
    return switch (status) {
      'approved' => approvedLabel,
      'called' => calledLabel,
      'booked' => bookedLabel,
      _ => rejectedLabel,
    };
  }
}

class _TimeLogItem extends StatelessWidget {
  const _TimeLogItem({
    required this.label,
    required this.time,
    required this.isCheckIn,
  });

  final String label;
  final String time;
  final bool isCheckIn;

  @override
  Widget build(BuildContext context) {
    final iconColor = isCheckIn
        ? AppColors.chartIncomeGreen
        : AppColors.logoutRed;

    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: isCheckIn
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0),
                  child: SvgAsset(
                    imagePath: AppAssets.logout,
                    height: 18.h,
                    color: iconColor,
                  ),
                )
              : SvgAsset(
                  imagePath: AppAssets.logout,
                  height: 18.h,
                  color: iconColor,
                ),
        ),

        // Space
        8.w.spaceHorizontal,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: styleW400S12.copyWith(
                  color: AppColors.text.withValues(alpha: 0.6),
                ),
              ),

              // Space
              2.h.spaceVertical,

              Text(time, style: styleW600S14),
            ],
          ),
        ),
      ],
    );
  }
}
