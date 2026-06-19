import 'package:society_managment/society_management.dart';

part 'visitor_history_state.dart';

enum VisitorHistoryWingFilter { all, wingA, wingB, wingC, wingD }

enum VisitorHistoryDateFilter {
  today,
  yesterday,
  last7Days,
  last30Days,
  customRange,
}

enum VisitorHistoryStatusFilter { all, approved, called, rejected }

class VisitorHistoryCubit extends Cubit<VisitorHistoryState> {
  VisitorHistoryCubit() : super(const VisitorHistoryState());

  static const List<Map<String, String>> _debugHistoryVisitors = [
    {
      'name': 'Flipkart - Delivery',
      'flat': 'A-302',
      'date': '16 Jun 2026',
      'date_key': '2026-06-16',
      'vehicle_no': 'GJ18EF9087',
      'check_in': '10:00 AM',
      'check_out': '06:15 PM',
      'status': 'approved',
      'wing': 'A',
    },
    {
      'name': 'Manisha Misra - Guest',
      'flat': 'B-204',
      'date': '16 Jun 2026',
      'date_key': '2026-06-16',
      'vehicle_no': 'GJ18EF9087',
      'check_in': '10:00 AM',
      'check_out': '04:00 PM',
      'status': 'called',
      'wing': 'B',
    },
    {
      'name': 'Rakesh Patel - Guest',
      'flat': 'C-110',
      'date': '16 Jun 2026',
      'date_key': '2026-06-16',
      'vehicle_no': 'GJ12CD5678',
      'check_in': '12:05 PM',
      'check_out': '08:35 PM',
      'status': 'rejected',
      'wing': 'C',
    },
    {
      'name': 'Swiggy - Delivery',
      'flat': 'A-103',
      'date': '17 Jun 2026',
      'date_key': '2026-06-17',
      'vehicle_no': 'GJ05AB1234',
      'check_in': '01:20 PM',
      'check_out': '02:10 PM',
      'status': 'approved',
      'wing': 'A',
    },
    {
      'name': 'Anjal Mehta - Guest',
      'flat': 'D-105',
      'date': '15 Jun 2026',
      'date_key': '2026-06-15',
      'vehicle_no': '',
      'check_in': '03:10 PM',
      'check_out': '07:45 PM',
      'status': 'called',
      'wing': 'D',
    },
    {
      'name': 'Amazon - Delivery',
      'flat': 'B-105',
      'date': '10 Jun 2026',
      'date_key': '2026-06-10',
      'vehicle_no': 'GJ22XY9012',
      'check_in': '11:30 AM',
      'check_out': '12:15 PM',
      'status': 'approved',
      'wing': 'B',
    },
  ];

  List<Map<String, String>> get historyVisitors {
    if (AppConstants.useMockData) return _debugHistoryVisitors;
    return [];
  }

  void onWingChipChanged(VisitorHistoryWingFilter filter) {
    emit(state.copyWith(wingFilter: filter));
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void applyFilters({
    VisitorHistoryDateFilter? dateFilter,
    VisitorHistoryStatusFilter? statusFilter,
    VisitorHistoryWingFilter? wingFilter,
  }) {
    emit(
      state.copyWith(
        dateFilter: dateFilter,
        statusFilter: statusFilter,
        wingFilter: wingFilter,
      ),
    );
  }

  void clearFilters() {
    emit(const VisitorHistoryState());
  }

  List<Map<String, String>> filteredVisitors() {
    return _applyFilters(historyVisitors);
  }

  List<Map<String, String>> _applyFilters(List<Map<String, String>> data) {
    Iterable<Map<String, String>> filtered = data;

    switch (state.wingFilter) {
      case VisitorHistoryWingFilter.all:
        break;
      case VisitorHistoryWingFilter.wingA:
        filtered = filtered.where((e) => (e['wing'] ?? '') == 'A');
        break;
      case VisitorHistoryWingFilter.wingB:
        filtered = filtered.where((e) => (e['wing'] ?? '') == 'B');
        break;
      case VisitorHistoryWingFilter.wingC:
        filtered = filtered.where((e) => (e['wing'] ?? '') == 'C');
        break;
      case VisitorHistoryWingFilter.wingD:
        filtered = filtered.where((e) => (e['wing'] ?? '') == 'D');
        break;
    }

    switch (state.statusFilter) {
      case VisitorHistoryStatusFilter.all:
        break;
      case VisitorHistoryStatusFilter.approved:
        filtered = filtered.where((e) => (e['status'] ?? '') == 'approved');
        break;
      case VisitorHistoryStatusFilter.called:
        filtered = filtered.where((e) => (e['status'] ?? '') == 'called');
        break;
      case VisitorHistoryStatusFilter.rejected:
        filtered = filtered.where((e) => (e['status'] ?? '') == 'rejected');
        break;
    }

    filtered = filtered.where(_matchesDateFilter);

    final query = state.searchQuery.trim().toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered.where((e) {
        final searchable = [
          e['name'],
          e['flat'],
          e['date'],
          e['vehicle_no'],
          e['check_in'],
          e['check_out'],
        ].join(' ').toLowerCase();
        return searchable.contains(query);
      });
    }

    return filtered.toList();
  }

  bool _matchesDateFilter(Map<String, String> visitor) {
    if (state.dateFilter == VisitorHistoryDateFilter.customRange) {
      return true;
    }

    final dateKey = visitor['date_key'] ?? '';
    if (dateKey.isEmpty) return true;

    final visitorDate = DateTime.tryParse(dateKey);
    if (visitorDate == null) return true;

    final today = DateTime(2026, 6, 17);
    final normalizedVisitorDate = DateTime(
      visitorDate.year,
      visitorDate.month,
      visitorDate.day,
    );
    final normalizedToday = DateTime(today.year, today.month, today.day);

    return switch (state.dateFilter) {
      VisitorHistoryDateFilter.today =>
        normalizedVisitorDate == normalizedToday,
      VisitorHistoryDateFilter.yesterday =>
        normalizedVisitorDate ==
        normalizedToday.subtract(const Duration(days: 1)),
      VisitorHistoryDateFilter.last7Days =>
        !normalizedVisitorDate.isBefore(
          normalizedToday.subtract(const Duration(days: 6)),
        ) &&
        !normalizedVisitorDate.isAfter(normalizedToday),
      VisitorHistoryDateFilter.last30Days =>
        !normalizedVisitorDate.isBefore(
          normalizedToday.subtract(const Duration(days: 29)),
        ) &&
        !normalizedVisitorDate.isAfter(normalizedToday),
      VisitorHistoryDateFilter.customRange => true,
    };
  }
}
