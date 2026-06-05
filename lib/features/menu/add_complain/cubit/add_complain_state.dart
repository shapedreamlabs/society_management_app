part of 'add_complain_cubit.dart';

class AddComplainState extends Equatable {
  const AddComplainState({this.priority});

  final String? priority;

  AddComplainState copyWith({String? priority}) {
    return AddComplainState(priority: priority ?? this.priority);
  }

  @override
  List<Object?> get props => [priority];
}
