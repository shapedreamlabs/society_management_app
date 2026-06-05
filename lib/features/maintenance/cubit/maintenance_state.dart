part of 'maintenance_cubit.dart';

class MaintenanceState extends Equatable {
  const MaintenanceState({
    this.selectedMonthIndex = 0,
    this.isBalanceVisible = true,
    this.isMaintenanceVisible = false,
    this.searchQuery = '',
    this.focusedMonth,
    this.netBalance = '2,35,000',
    this.balanceChange = '18,400',
    this.totalIncome = '3,10,600',
    this.totalExpenses = '70,588',
    this.netMaintenance = '40,000',
    this.pendingMaintenance = '10,000',
    this.expectedMaintenance = '50,000',
    this.members = _defaultMembers,
    this.memberFilter = MaintenanceMemberFilter.all,
  });

  final int selectedMonthIndex;
  final MaintenanceMemberFilter memberFilter;
  final bool isBalanceVisible;
  final bool isMaintenanceVisible;
  final String searchQuery;
  final DateTime? focusedMonth;
  final String netBalance;
  final String balanceChange;
  final String totalIncome;
  final String totalExpenses;
  final String netMaintenance;
  final String pendingMaintenance;
  final String expectedMaintenance;
  final List<MaintenanceMember> members;

  static const List<MaintenanceMember> _defaultMembers = [
    MaintenanceMember(
      id: '1',
      name: 'Suresh Doshi',
      flat: 'A-101',
      amount: '3500',
    ),
    MaintenanceMember(
      id: '2',
      name: 'Meera Patel',
      flat: 'A-102',
      amount: '3500',
      status: MaintenancePaymentStatus.completed,
      isSelected: true,
    ),
    MaintenanceMember(
      id: '3',
      name: 'Rahul Shah',
      flat: 'A-103',
      amount: '3500',
    ),
    MaintenanceMember(
      id: '4',
      name: 'Pooja Mehta',
      flat: 'A-104',
      amount: '3500',
      status: MaintenancePaymentStatus.completed,
    ),
    MaintenanceMember(
      id: '5',
      name: 'Karan Patel',
      flat: 'A-105',
      amount: '3500',
    ),
    MaintenanceMember(
      id: '6',
      name: 'Sneha Joshi',
      flat: 'A-106',
      amount: '3500',
      status: MaintenancePaymentStatus.completed,
    ),
    MaintenanceMember(
      id: '7',
      name: 'Amit Trivedi',
      flat: 'A-107',
      amount: '3500',
    ),
    MaintenanceMember(
      id: '8',
      name: 'Neha Desai',
      flat: 'A-108',
      amount: '3500',
    ),
  ];

  MaintenanceState copyWith({
    int? selectedMonthIndex,
    bool? isBalanceVisible,
    bool? isMaintenanceVisible,
    String? searchQuery,
    DateTime? focusedMonth,
    String? netBalance,
    String? balanceChange,
    String? totalIncome,
    String? totalExpenses,
    String? netMaintenance,
    String? pendingMaintenance,
    String? expectedMaintenance,
    List<MaintenanceMember>? members,
    MaintenanceMemberFilter? memberFilter,
  }) {
    return MaintenanceState(
      selectedMonthIndex: selectedMonthIndex ?? this.selectedMonthIndex,
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
      isMaintenanceVisible: isMaintenanceVisible ?? this.isMaintenanceVisible,
      searchQuery: searchQuery ?? this.searchQuery,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      netBalance: netBalance ?? this.netBalance,
      balanceChange: balanceChange ?? this.balanceChange,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      netMaintenance: netMaintenance ?? this.netMaintenance,
      pendingMaintenance: pendingMaintenance ?? this.pendingMaintenance,
      expectedMaintenance: expectedMaintenance ?? this.expectedMaintenance,
      members: members ?? this.members,
      memberFilter: memberFilter ?? this.memberFilter,
    );
  }

  @override
  List<Object?> get props => [
    memberFilter,
    selectedMonthIndex,
    isBalanceVisible,
    isMaintenanceVisible,
    searchQuery,
    focusedMonth,
    netBalance,
    balanceChange,
    totalIncome,
    totalExpenses,
    netMaintenance,
    pendingMaintenance,
    expectedMaintenance,
    members,
  ];
}
