part of 'vehicle_lookup_cubit.dart';

class VehicleLookupState extends Equatable {
  const VehicleLookupState({this.searchQuery = ''});

  final String searchQuery;

  VehicleLookupState copyWith({String? searchQuery}) {
    return VehicleLookupState(searchQuery: searchQuery ?? this.searchQuery);
  }

  @override
  List<Object?> get props => [searchQuery];
}
