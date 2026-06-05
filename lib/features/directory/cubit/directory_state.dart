part of 'directory_cubit.dart';

class DirectoryState extends Equatable {
  const DirectoryState({
    this.filter = DirectoryFilter.all,
    this.searchQuery = '',
  });

  final DirectoryFilter filter;
  final String searchQuery;

  DirectoryState copyWith({DirectoryFilter? filter, String? searchQuery}) {
    return DirectoryState(
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [filter, searchQuery];
}
