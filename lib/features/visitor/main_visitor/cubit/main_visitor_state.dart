part of 'main_visitor_cubit.dart';

class MainVisitorState extends Equatable {
  const MainVisitorState({
    this.filter = MainVisitorFilter.all,
    this.searchQuery = '',
  });

  final MainVisitorFilter filter;
  final String searchQuery;

  MainVisitorState copyWith({MainVisitorFilter? filter, String? searchQuery}) {
    return MainVisitorState(
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [filter, searchQuery];
}
