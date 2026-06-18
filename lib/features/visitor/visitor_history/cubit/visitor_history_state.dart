part of 'visitor_history_cubit.dart';

class VisitorHistoryState extends Equatable {
  const VisitorHistoryState({
    this.wingFilter = VisitorHistoryWingFilter.all,
    this.dateFilter = VisitorHistoryDateFilter.today,
    this.statusFilter = VisitorHistoryStatusFilter.all,
    this.searchQuery = '',
  });

  final VisitorHistoryWingFilter wingFilter;
  final VisitorHistoryDateFilter dateFilter;
  final VisitorHistoryStatusFilter statusFilter;
  final String searchQuery;

  int get wingChipSelectedIndex {
    return switch (wingFilter) {
      VisitorHistoryWingFilter.all => 0,
      VisitorHistoryWingFilter.wingA => 1,
      VisitorHistoryWingFilter.wingB => 2,
      VisitorHistoryWingFilter.wingC => 3,
      VisitorHistoryWingFilter.wingD => -1,
    };
  }

  VisitorHistoryState copyWith({
    VisitorHistoryWingFilter? wingFilter,
    VisitorHistoryDateFilter? dateFilter,
    VisitorHistoryStatusFilter? statusFilter,
    String? searchQuery,
  }) {
    return VisitorHistoryState(
      wingFilter: wingFilter ?? this.wingFilter,
      dateFilter: dateFilter ?? this.dateFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    wingFilter,
    dateFilter,
    statusFilter,
    searchQuery,
  ];
}
