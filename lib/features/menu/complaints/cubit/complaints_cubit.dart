import 'package:society_managment/society_managment.dart';

part 'complaints_state.dart';

enum ComplaintsFilter { all, urgent, normal, resolved }

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit() : super(const ComplaintsState());

  static const List<Map<String, String>> _debugItems = [
    {
      'title': 'Water leakage – B-203',
      'meta': 'Ramesh Shah · May 2',
      'status': 'urgent',
    },
    {
      'title': 'Garbage not collected – A-102',
      'meta': 'Pooja Shah · Apr 30',
      'status': 'normal',
    },
    {
      'title': 'Water supply issue – C-210',
      'meta': 'Anjali Mehta · Apr 28',
      'status': 'urgent',
    },
    {
      'title': 'Lift not working – A Wing',
      'meta': 'Neha Joshi · May 2',
      'status': 'urgent',
    },
    {
      'title': 'Street light not working – Gate 1',
      'meta': 'Vikram Singh · Apr 29',
      'status': 'resolved',
    },
  ];

  List<Map<String, String>> get allItems {
    if (AppConstants.useMockData) return _debugItems;
    return [];
  }

  void onFilterChanged(ComplaintsFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void onAddComplainTap(BuildContext context) {
    context.navigator.pushNamed(AddComplainScreen.routeName);
  }

  List<Map<String, String>> filteredItems() {
    final items = allItems;
    switch (state.filter) {
      case ComplaintsFilter.all:
        return items;
      case ComplaintsFilter.urgent:
        return items.where((e) => (e['status'] ?? '') == 'urgent').toList();
      case ComplaintsFilter.normal:
        return items.where((e) => (e['status'] ?? '') == 'normal').toList();
      case ComplaintsFilter.resolved:
        return items.where((e) => (e['status'] ?? '') == 'resolved').toList();
    }
  }
}
