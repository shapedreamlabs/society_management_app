import 'package:society_managment/society_managment.dart';

part 'maintenance_history_state.dart';

class MaintenanceHistoryCubit extends Cubit<MaintenanceHistoryState> {
  MaintenanceHistoryCubit() : super(const MaintenanceHistoryState());

  static const List<MaintenanceMember> _allMembers = [
    MaintenanceMember(
      id: 'ov1',
      name: 'Suresh Doshi',
      flat: 'A-403',
      amount: '3200',
    ),
    MaintenanceMember(
      id: 'ov2',
      name: 'Meera Patel',
      flat: 'A-402',
      amount: '3200',
      status: MaintenancePaymentStatus.completed,
    ),
    MaintenanceMember(
      id: 'ov3',
      name: 'Rahul Shah',
      flat: 'A-401',
      amount: '3200',
    ),
    MaintenanceMember(
      id: 'ov4',
      name: 'Pooja Mehta',
      flat: 'A-404',
      amount: '3200',
      status: MaintenancePaymentStatus.completed,
    ),
    MaintenanceMember(
      id: '5',
      name: 'Karan Patel',
      flat: 'A-405',
      amount: '3500',
    ),
    MaintenanceMember(
      id: '6',
      name: 'Sneha Joshi',
      flat: 'A-406',
      amount: '3500',
      status: MaintenancePaymentStatus.completed,
    ),
    MaintenanceMember(
      id: '7',
      name: 'Amit Trivedi',
      flat: 'A-407',
      amount: '3500',
    ),
    MaintenanceMember(
      id: '8',
      name: 'Neha Desai',
      flat: 'A-408',
      amount: '3500',
    ),
  ];

  List<MaintenanceMember> get _items {
    if (AppConstants.useMockData) {
      return _allMembers;
    }
    return [];
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  List<MaintenanceMember> filteredItems() {
    final query = state.searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _items;
    }

    return _items.where((item) {
      final searchable = '${item.name} ${item.flat} ${item.amount}'
          .toLowerCase();
      return searchable.contains(query);
    }).toList();
  }
}
