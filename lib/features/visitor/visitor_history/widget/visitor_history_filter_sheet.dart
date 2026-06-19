import 'package:society_managment/society_management.dart';

class VisitorHistoryFilterSheet extends StatefulWidget {
  const VisitorHistoryFilterSheet({
    super.key,
    required this.initialDateFilter,
    required this.initialStatusFilter,
    required this.initialWingFilter,
  });

  final VisitorHistoryDateFilter initialDateFilter;
  final VisitorHistoryStatusFilter initialStatusFilter;
  final VisitorHistoryWingFilter initialWingFilter;

  @override
  State<VisitorHistoryFilterSheet> createState() =>
      _VisitorHistoryFilterSheetState();
}

class _VisitorHistoryFilterSheetState extends State<VisitorHistoryFilterSheet> {
  late VisitorHistoryDateFilter _dateFilter;
  late VisitorHistoryStatusFilter _statusFilter;
  late VisitorHistoryWingFilter _wingFilter;

  @override
  void initState() {
    super.initState();
    _dateFilter = widget.initialDateFilter;
    _statusFilter = widget.initialStatusFilter;
    _wingFilter = widget.initialWingFilter;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FilterSection(
            title: l10n?.dateRange ?? '',
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildChip(
                  label: l10n?.today ?? '',
                  selected: _dateFilter == VisitorHistoryDateFilter.today,
                  onTap: () => setState(
                    () => _dateFilter = VisitorHistoryDateFilter.today,
                  ),
                ),
                _buildChip(
                  label: l10n?.yesterday ?? '',
                  selected: _dateFilter == VisitorHistoryDateFilter.yesterday,
                  onTap: () => setState(
                    () => _dateFilter = VisitorHistoryDateFilter.yesterday,
                  ),
                ),
                _buildChip(
                  label: l10n?.last7Days ?? '',
                  selected: _dateFilter == VisitorHistoryDateFilter.last7Days,
                  onTap: () => setState(
                    () => _dateFilter = VisitorHistoryDateFilter.last7Days,
                  ),
                ),
                _buildChip(
                  label: l10n?.last30Days ?? '',
                  selected: _dateFilter == VisitorHistoryDateFilter.last30Days,
                  onTap: () => setState(
                    () => _dateFilter = VisitorHistoryDateFilter.last30Days,
                  ),
                ),
                _buildChip(
                  label: l10n?.customRange ?? '',
                  selected:
                      _dateFilter == VisitorHistoryDateFilter.customRange,
                  onTap: () => setState(
                    () => _dateFilter = VisitorHistoryDateFilter.customRange,
                  ),
                ),
              ],
            ),
          ),

          // Space
          20.h.spaceVertical,

          _FilterSection(
            title: l10n?.visitorStatus ?? '',
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildChip(
                  label: l10n?.all ?? '',
                  selected: _statusFilter == VisitorHistoryStatusFilter.all,
                  onTap: () => setState(
                    () => _statusFilter = VisitorHistoryStatusFilter.all,
                  ),
                ),
                _buildChip(
                  label: l10n?.approved ?? '',
                  selected:
                      _statusFilter == VisitorHistoryStatusFilter.approved,
                  onTap: () => setState(
                    () => _statusFilter = VisitorHistoryStatusFilter.approved,
                  ),
                ),
                _buildChip(
                  label: l10n?.called ?? '',
                  selected: _statusFilter == VisitorHistoryStatusFilter.called,
                  onTap: () => setState(
                    () => _statusFilter = VisitorHistoryStatusFilter.called,
                  ),
                ),
                _buildChip(
                  label: l10n?.rejected ?? '',
                  selected:
                      _statusFilter == VisitorHistoryStatusFilter.rejected,
                  onTap: () => setState(
                    () => _statusFilter = VisitorHistoryStatusFilter.rejected,
                  ),
                ),
              ],
            ),
          ),

          // Space
          20.h.spaceVertical,

          _FilterSection(
            title: l10n?.wing ?? '',
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildChip(
                  label: l10n?.allWing ?? '',
                  selected: _wingFilter == VisitorHistoryWingFilter.all,
                  onTap: () => setState(
                    () => _wingFilter = VisitorHistoryWingFilter.all,
                  ),
                ),
                _buildChip(
                  label: l10n?.wingA ?? '',
                  selected: _wingFilter == VisitorHistoryWingFilter.wingA,
                  onTap: () => setState(
                    () => _wingFilter = VisitorHistoryWingFilter.wingA,
                  ),
                ),
                _buildChip(
                  label: l10n?.wingB ?? '',
                  selected: _wingFilter == VisitorHistoryWingFilter.wingB,
                  onTap: () => setState(
                    () => _wingFilter = VisitorHistoryWingFilter.wingB,
                  ),
                ),
                _buildChip(
                  label: l10n?.wingC ?? '',
                  selected: _wingFilter == VisitorHistoryWingFilter.wingC,
                  onTap: () => setState(
                    () => _wingFilter = VisitorHistoryWingFilter.wingC,
                  ),
                ),
                _buildChip(
                  label: l10n?.wingD ?? '',
                  selected: _wingFilter == VisitorHistoryWingFilter.wingD,
                  onTap: () => setState(
                    () => _wingFilter = VisitorHistoryWingFilter.wingD,
                  ),
                ),
              ],
            ),
          ),

          // Space
          24.h.spaceVertical,

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: l10n?.clearAll ?? '',
                  buttonColor: AppColors.white,
                  borderColor: AppColors.text.withValues(alpha: 0.15),
                  textColor: AppColors.text,
                  onTap: () {
                    setState(() {
                      _dateFilter = VisitorHistoryDateFilter.today;
                      _statusFilter = VisitorHistoryStatusFilter.all;
                      _wingFilter = VisitorHistoryWingFilter.all;
                    });
                  },
                ),
              ),

              // Space
              12.w.spaceHorizontal,

              Expanded(
                child: CustomButton(
                  title: l10n?.apply ?? '',
                  onTap: () => context.navigator.pop(
                    (
                      dateFilter: _dateFilter,
                      statusFilter: _statusFilter,
                      wingFilter: _wingFilter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return CommonFilterChip(
      label: label,
      selected: selected,
      onTap: onTap,
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: styleW600S16),

        // Space
        12.h.spaceVertical,

        child,
      ],
    );
  }
}

typedef VisitorHistoryFilterResult = ({
  VisitorHistoryDateFilter dateFilter,
  VisitorHistoryStatusFilter statusFilter,
  VisitorHistoryWingFilter wingFilter,
});
