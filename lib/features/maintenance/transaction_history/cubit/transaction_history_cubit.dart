import 'package:society_managment/society_managment.dart';

part 'transaction_history_state.dart';

class TransactionHistoryCubit extends Cubit<TransactionHistoryState> {
  TransactionHistoryCubit() : super(const TransactionHistoryState());

  static const List<MaintenanceTransaction> _allTransactions = [
    MaintenanceTransaction(
      name: 'Suresh Doshi',
      flat: 'A-403',
      category: AppLabelKeys.maintenance,
      amount: '+3500',
      isCredit: true,
      date: '29 Apr',
    ),
    MaintenanceTransaction(
      name: 'Meera Patel',
      flat: 'A-402',
      category: AppLabelKeys.transferFees,
      amount: '-15,000',
      isCredit: false,
      date: '29 Apr',
    ),
    MaintenanceTransaction(
      name: 'Rahul Shah',
      flat: 'A-401',
      category: AppLabelKeys.securityGuard,
      amount: '+3500',
      isCredit: true,
      date: '29 Apr',
    ),
    MaintenanceTransaction(
      name: 'Pooja Mehta',
      flat: 'A-404',
      category: AppLabelKeys.maintenance,
      amount: '+3500',
      isCredit: true,
      date: '28 Apr',
    ),
    MaintenanceTransaction(
      name: 'Karan Patel',
      flat: 'A-405',
      category: AppLabelKeys.banquetHall,
      amount: '+12,000',
      isCredit: true,
      date: '27 Apr',
    ),
    MaintenanceTransaction(
      name: 'Sneha Joshi',
      flat: 'A-406',
      category: AppLabelKeys.festivalFund,
      amount: '-8,500',
      isCredit: false,
      date: '26 Apr',
    ),
  ];

  List<MaintenanceTransaction> get _items {
    if (AppConstants.useMockData) {
      return _allTransactions;
    }
    return [];
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  List<MaintenanceTransaction> filteredItems() {
    final query = state.searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _items;
    }

    return _items.where((item) {
      final searchable =
          '${item.name} ${item.flat} ${item.category} ${item.amount}'
              .toLowerCase();
      return searchable.contains(query);
    }).toList();
  }
}
