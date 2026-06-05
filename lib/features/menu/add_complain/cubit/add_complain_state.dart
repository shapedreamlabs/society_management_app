part of 'add_complain_cubit.dart';

class AddComplainState extends Equatable {
  const AddComplainState({this.priority, this.date = ''});

  final String? priority;
  final String date;

  AddComplainState copyWith({String? priority, String? date}) {
    return AddComplainState(
      priority: priority ?? this.priority,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [priority, date];
}
