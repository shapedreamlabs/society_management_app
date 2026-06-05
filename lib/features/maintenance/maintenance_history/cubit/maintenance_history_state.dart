part of 'maintenance_history_cubit.dart';

class MaintenanceHistoryState extends Equatable {
  const MaintenanceHistoryState({this.searchQuery = ''});

  final String searchQuery;

  MaintenanceHistoryState copyWith({String? searchQuery}) {
    return MaintenanceHistoryState(
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [searchQuery];
}
