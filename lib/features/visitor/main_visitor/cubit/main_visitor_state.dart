part of 'main_visitor_cubit.dart';

class MainVisitorState extends Equatable {
  const MainVisitorState({
    this.filter = MainVisitorFilter.all,
    this.searchQuery = '',
    this.todayVisitors = const [],
    this.otherVisitors = const [],
  });

  final MainVisitorFilter filter;
  final String searchQuery;
  final List<Map<String, String>> todayVisitors;
  final List<Map<String, String>> otherVisitors;

  MainVisitorState copyWith({
    MainVisitorFilter? filter,
    String? searchQuery,
    List<Map<String, String>>? todayVisitors,
    List<Map<String, String>>? otherVisitors,
  }) {
    return MainVisitorState(
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
      todayVisitors: todayVisitors ?? this.todayVisitors,
      otherVisitors: otherVisitors ?? this.otherVisitors,
    );
  }

  @override
  List<Object?> get props => [
    filter,
    searchQuery,
    todayVisitors,
    otherVisitors,
  ];
}
