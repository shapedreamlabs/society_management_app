import 'package:society_managment/society_managment.dart';

part 'main_visitor_state.dart';

enum MainVisitorFilter { all, wingA, wingB, wingC }

class MainVisitorCubit extends Cubit<MainVisitorState> {
  MainVisitorCubit()
    : super(
        MainVisitorState(
          todayVisitors: AppConstants.useMockData
              ? _initialTodayVisitors()
              : [],
          otherVisitors: AppConstants.useMockData
              ? _initialOtherVisitors()
              : [],
        ),
      );

  static List<Map<String, String>> _initialTodayVisitors() => [
    {
      'id': 't1',
      'name': 'Flipkart - Delivery',
      'flat': 'A-103',
      'date': '16 Jun 2026',
      'vehicle_no': 'GJ18EF9087',
      'check_in': '09:45 AM',
      'check_out': '10:10 AM',
      'status': 'rejected',
      'wing': 'A',
    },
    {
      'id': 't2',
      'name': 'Swiggy - Delivery',
      'flat': 'B-204',
      'date': '16 Jun 2026',
      'vehicle_no': 'GJ05AB1234',
      'check_in': '01:20 PM',
      'check_out': '',
      'status': 'approved',
      'wing': 'B',
    },
    {
      'id': 't3',
      'name': 'Rakesh Patel - Guest',
      'flat': 'C-110',
      'date': '16 Jun 2026',
      'vehicle_no': 'GJ12CD5678',
      'check_in': '12:05 PM',
      'check_out': '08:35 PM',
      'status': 'rejected',
      'wing': 'C',
    },
    {
      'id': 't4',
      'name': 'Anjal Mehta - Guest',
      'flat': 'B-105',
      'date': '16 Jun 2026',
      'vehicle_no': '',
      'check_in': '03:10 PM',
      'check_out': '',
      'status': 'approved',
      'wing': 'B',
    },
  ];

  static List<Map<String, String>> _initialOtherVisitors() => [
    {
      'id': 'o1',
      'name': 'Flipkart - Delivery',
      'flat': 'A-103',
      'date': '18 Jun 2026',
      'vehicle_no': 'GJ18EF9087',
      'status': 'booked',
      'wing': 'A',
    },
    {
      'id': 'o2',
      'name': 'Manisha Misra - Guest',
      'flat': 'B-204',
      'date': '19 Jun 2026',
      'vehicle_no': 'GJ05AB1234',
      'status': 'booked',
      'wing': 'B',
    },
  ];

  void onFilterChanged(MainVisitorFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void onVisitorCheckOut(String visitorId, {required bool isTodaySection}) {
    final visitors = isTodaySection
        ? List<Map<String, String>>.from(state.todayVisitors)
        : List<Map<String, String>>.from(state.otherVisitors);

    final index = visitors.indexWhere((visitor) => visitor['id'] == visitorId);
    if (index == -1) return;

    final updatedVisitor = Map<String, String>.from(visitors[index]);
    updatedVisitor['check_out'] = DateTime.now().toHhMmA ?? '';
    visitors[index] = updatedVisitor;

    emit(
      state.copyWith(
        todayVisitors: isTodaySection ? visitors : null,
        otherVisitors: isTodaySection ? null : visitors,
      ),
    );
  }

  List<Map<String, String>> filteredTodayVisitors() {
    return _applyFilterAndSearch(state.todayVisitors);
  }

  List<Map<String, String>> filteredOtherVisitors() {
    return _applyFilterAndSearch(state.otherVisitors);
  }

  List<Map<String, String>> _applyFilterAndSearch(
    List<Map<String, String>> data,
  ) {
    Iterable<Map<String, String>> filtered = data;

    switch (state.filter) {
      case MainVisitorFilter.all:
        break;
      case MainVisitorFilter.wingA:
        filtered = filtered.where((e) => (e['wing'] ?? '') == 'A');
        break;
      case MainVisitorFilter.wingB:
        filtered = filtered.where((e) => (e['wing'] ?? '') == 'B');
        break;
      case MainVisitorFilter.wingC:
        filtered = filtered.where((e) => (e['wing'] ?? '') == 'C');
        break;
    }

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
}
