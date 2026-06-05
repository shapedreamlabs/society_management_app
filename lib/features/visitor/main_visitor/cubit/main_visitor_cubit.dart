import 'package:society_managment/society_managment.dart';

part 'main_visitor_state.dart';

enum MainVisitorFilter { all, wingA, wingB, wingC }

class MainVisitorCubit extends Cubit<MainVisitorState> {
  MainVisitorCubit() : super(const MainVisitorState());

  static const List<Map<String, String>> _debugTodayVisitors = [
    {
      'name': 'Flipkart - Delivery',
      'meta': 'A-103 · In 09:45 · Out 10:10',
      'status': 'rejected',
      'wing': 'A',
    },
    {
      'name': 'Swiggy - Delivery',
      'meta': 'B-204 · In 13:20',
      'status': 'approved',
      'wing': 'B',
    },
    {
      'name': 'Rakesh Patel - Guest',
      'meta': 'C-110 · In 12:05 · Out 20:35',
      'status': 'rejected',
      'wing': 'C',
    },
    {
      'name': 'Anjal Mehta - Guest',
      'meta': 'B-105 · In 15:10',
      'status': 'approved',
      'wing': 'B',
    },
  ];

  static const List<Map<String, String>> _debugOtherVisitors = [
    {
      'name': 'Flipkart - Delivery',
      'meta': 'A-103 · In 09:45 · Out 10:10',
      'status': 'rejected',
      'wing': 'A',
    },
    {
      'name': 'Swiggy - Delivery',
      'meta': 'B-204 · In 13:20',
      'status': 'rejected',
      'wing': 'B',
    },
  ];

  List<Map<String, String>> get todayVisitors {
    if (AppConstants.useMockData) return _debugTodayVisitors;
    return [];
  }

  List<Map<String, String>> get otherVisitors {
    if (AppConstants.useMockData) return _debugOtherVisitors;
    return [];
  }

  void onFilterChanged(MainVisitorFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  List<Map<String, String>> filteredTodayVisitors() {
    return _applyFilterAndSearch(todayVisitors);
  }

  List<Map<String, String>> filteredOtherVisitors() {
    return _applyFilterAndSearch(otherVisitors);
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
        final name = (e['name'] ?? '').toLowerCase();
        final meta = (e['meta'] ?? '').toLowerCase();
        return name.contains(query) || meta.contains(query);
      });
    }

    return filtered.toList();
  }
}
