import 'package:society_managment/society_managment.dart';

part 'maintenance_state.dart';

class MaintenanceCubit extends Cubit<MaintenanceState> {
  static const List<MaintenanceTransaction> _overviewTransactions = [
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
  ];

  static const List<MaintenanceMember> _overviewMaintenanceItems = [
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
  ];

  MaintenanceCubit(BuildContext context) : super(MaintenanceState()) {
    _init(context);
  }

  void _init(BuildContext context) {
    final now = DateTime.now();
    emit(
      state.copyWith(
        focusedMonth: DateTime(now.year, now.month),
        selectedMonthIndex: now.month - 1,
      ),
    );
  }

  List<String> monthLabels(AppLocalizations? l10n) => [
    l10n?.january ?? '',
    l10n?.february ?? '',
    l10n?.march ?? '',
    l10n?.april ?? '',
    l10n?.may ?? '',
    l10n?.june ?? '',
    l10n?.july ?? '',
    l10n?.august ?? '',
    l10n?.september ?? '',
    l10n?.october ?? '',
    l10n?.november ?? '',
    l10n?.december ?? '',
  ];

  String netBalancePeriodLabel(String localeName) {
    final month = state.focusedMonth ?? DateTime.now();
    return LocalizationLabels.formatMonthYearUpper(month, localeName);
  }

  void onMonthSelected(int index) {
    emit(state.copyWith(selectedMonthIndex: index));
  }

  void onMemberFilterChanged(MaintenanceMemberFilter filter) {
    emit(state.copyWith(memberFilter: filter));
  }

  void onSearchChanged(String value) {
    emit(state.copyWith(searchQuery: value));
  }

  void toggleBalanceVisibility() {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }

  void toggleMaintenanceVisibility() {
    emit(state.copyWith(isMaintenanceVisible: !state.isMaintenanceVisible));
  }

  List<MaintenanceTransaction> overviewTransactions() {
    return _filterBySearch(
      _overviewTransactions,
      (item) => '${item.name} ${item.flat} ${item.category}'.toLowerCase(),
    );
  }

  List<MaintenanceMember> overviewMaintenanceItems() {
    return _filterBySearch(
      _overviewMaintenanceItems,
      (item) => '${item.name} ${item.flat}'.toLowerCase(),
    );
  }

  List<T> _filterBySearch<T>(
    List<T> data,
    String Function(T item) searchableText,
  ) {
    final query = state.searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return data;
    }
    return data.where((item) => searchableText(item).contains(query)).toList();
  }

  List<MaintenanceMember> maintenanceMembers() {
    Iterable<MaintenanceMember> members = state.members;

    if (state.isMemberEditMode) {
      members = members.where(
        (member) => member.status == MaintenancePaymentStatus.pending,
      );
    } else {
      switch (state.memberFilter) {
        case MaintenanceMemberFilter.pending:
          members = members.where(
            (member) => member.status == MaintenancePaymentStatus.pending,
          );
        case MaintenanceMemberFilter.completed:
          members = members.where(
            (member) => member.status == MaintenancePaymentStatus.completed,
          );
        case MaintenanceMemberFilter.all:
          break;
      }
    }

    final query = state.searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return members.toList();
    }
    return members
        .where(
          (member) =>
              member.name.toLowerCase().contains(query) ||
              member.flat.toLowerCase().contains(query),
        )
        .toList();
  }

  void enterMemberEditMode() {
    final members = state.members
        .map((member) => member.copyWith(isSelected: false))
        .toList();

    emit(
      state.copyWith(
        isMemberEditMode: true,
        members: members,
      ),
    );
  }

  void exitMemberEditMode() {
    final members = state.members
        .map((member) => member.copyWith(isSelected: false))
        .toList();

    emit(state.copyWith(isMemberEditMode: false, members: members));
  }

  void toggleMemberSelected(String id) {
    if (!state.isMemberEditMode) {
      return;
    }

    final members = state.members
        .map(
          (member) => member.id == id
              ? member.copyWith(isSelected: !member.isSelected)
              : member,
        )
        .toList();
    emit(state.copyWith(members: members));
  }

  void toggleSelectAllMembers() {
    if (!state.isMemberEditMode) {
      return;
    }

    final pendingMembers = state.members.where(
      (member) => member.status == MaintenancePaymentStatus.pending,
    );
    final pendingIds = pendingMembers.map((member) => member.id).toSet();
    final allSelected = pendingMembers.every((member) => member.isSelected);

    final members = state.members
        .map(
          (member) => pendingIds.contains(member.id)
              ? member.copyWith(isSelected: !allSelected)
              : member.copyWith(isSelected: false),
        )
        .toList();
    emit(state.copyWith(members: members));
  }

  void onMaintenanceFabPressed() {
    if (!state.isMemberEditMode) {
      return;
    }

    final selectedIds = state.members
        .where(
          (member) =>
              member.isSelected &&
              member.status == MaintenancePaymentStatus.pending,
        )
        .map((member) => member.id)
        .toList();
    if (selectedIds.isEmpty) {
      return;
    }

    final selectedIdSet = selectedIds.toSet();
    final members = state.members
        .map(
          (member) => selectedIdSet.contains(member.id)
              ? member.copyWith(
                  status: MaintenancePaymentStatus.completed,
                  isSelected: false,
                )
              : member,
        )
        .toList();

    emit(
      state.copyWith(
        members: members,
        isMemberEditMode: false,
      ),
    );
  }
}
