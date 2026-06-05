import 'dart:math' as math;

import 'package:society_managment/society_managment.dart';

class MonthlyTrendsChart extends StatelessWidget {
  const MonthlyTrendsChart({super.key, required this.l10n});

  final AppLocalizations? l10n;

  static const List<String> _monthLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
  static const List<double> _incomeValues = [60, 70, 65, 50, 48];
  static const List<double> _expenseValues = [45, 22, 50, 35, 70];

  static const List<double> _niceIntervalSteps = [
    1,
    2,
    5,
    10,
    15,
    20,
    25,
    30,
    40,
    50,
    75,
    100,
    150,
    200,
    250,
    500,
    1000,
  ];

  @override
  Widget build(BuildContext context) {
    final scale = _computeScale([..._incomeValues, ..._expenseValues]);
    final maxY = scale.maxY;
    final interval = scale.interval;
    final milestones = [0.0, interval, interval * 2, maxY];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n?.monthlyTrends ?? '', style: styleW600S18),
          20.h.spaceVertical,
          SizedBox(
            height: 200.h,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                minY: 0,
                groupsSpace: 18,
                alignment: BarChartAlignment.spaceAround,
                barTouchData: const BarTouchData(enabled: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: interval,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.text.withValues(alpha: 0.12),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36.w,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        final stepIndex = (value / interval).round();
                        if (stepIndex < 0 || stepIndex > 3) {
                          return const SizedBox.shrink();
                        }
                        final milestone = milestones[stepIndex];
                        if ((value - milestone).abs() > interval * 0.15) {
                          return const SizedBox.shrink();
                        }
                        return _axisLabel(_formatAxisValue(milestone), meta);
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28.h,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= _monthLabels.length) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            _monthLabels[index],
                            style: styleW400S12.copyWith(
                              color: AppColors.text.withValues(alpha: 0.6),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(_monthLabels.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barsSpace: 6,
                    barRods: [
                      BarChartRodData(
                        toY: _incomeValues[index],
                        width: 14.w,
                        color: AppColors.chartIncomeGreen,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6.r),
                        ),
                      ),
                      BarChartRodData(
                        toY: _expenseValues[index],
                        width: 14.w,
                        color: AppColors.chartExpenseRed,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6.r),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              duration: Duration.zero,
            ),
          ),
          12.h.spaceVertical,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(
                color: AppColors.chartIncomeGreen,
                label: l10n?.income ?? '',
              ),
              24.w.spaceHorizontal,
              _LegendItem(
                color: AppColors.chartExpenseRed,
                label: l10n?.expenses ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }

  static _ChartScale _computeScale(List<double> values) {
    if (values.isEmpty) {
      return const _ChartScale(maxY: 40, interval: 10);
    }

    final peak = values.reduce(math.max);
    if (peak <= 0) {
      return const _ChartScale(maxY: 10, interval: 2.5);
    }

    final paddedPeak = peak * 1.12;
    for (final step in _niceIntervalSteps) {
      final maxY = step * 3;
      if (maxY >= paddedPeak) {
        return _ChartScale(maxY: maxY, interval: step);
      }
    }

    final interval = _niceInterval(paddedPeak / 3);
    return _ChartScale(maxY: interval * 3, interval: interval);
  }

  static double _niceInterval(double raw) {
    for (final step in _niceIntervalSteps) {
      if (step >= raw) {
        return step;
      }
    }

    final magnitude = math
        .pow(10, (math.log(raw) / math.ln10).floor())
        .toDouble();
    final normalized = raw / magnitude;
    final niceFactor = normalized <= 1
        ? 1.0
        : normalized <= 2
        ? 2.0
        : normalized <= 5
        ? 5.0
        : 10.0;
    return niceFactor * magnitude;
  }

  static String _formatAxisValue(double value) {
    if (value == 0) {
      return '0k';
    }
    if (value >= 1000) {
      final inK = value / 1000;
      return inK == inK.roundToDouble()
          ? '${inK.toInt()}k'
          : '${inK.toStringAsFixed(1)}k';
    }
    return value == value.roundToDouble()
        ? '${value.toInt()}k'
        : '${value.toStringAsFixed(1)}k';
  }

  Widget _axisLabel(String text, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: styleW400S12.copyWith(
          color: AppColors.text.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _ChartScale {
  const _ChartScale({required this.maxY, required this.interval});

  final double maxY;
  final double interval;
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        6.w.spaceHorizontal,
        Text(
          label,
          style: styleW400S12.copyWith(
            color: AppColors.text.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
