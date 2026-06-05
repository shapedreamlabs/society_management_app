part of 'complaints_cubit.dart';

class ComplaintsState extends Equatable {
  const ComplaintsState({this.filter = ComplaintsFilter.all});

  final ComplaintsFilter filter;

  ComplaintsState copyWith({ComplaintsFilter? filter}) {
    return ComplaintsState(filter: filter ?? this.filter);
  }

  @override
  List<Object?> get props => [filter];
}
