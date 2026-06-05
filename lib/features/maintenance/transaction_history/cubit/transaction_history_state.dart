part of 'transaction_history_cubit.dart';

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState({this.searchQuery = ''});

  final String searchQuery;

  TransactionHistoryState copyWith({String? searchQuery}) {
    return TransactionHistoryState(
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [searchQuery];
}
