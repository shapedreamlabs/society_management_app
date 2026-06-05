import 'package:society_managment/society_managment.dart';

part 'vehicle_lookup_state.dart';

class VehicleLookupCubit extends Cubit<VehicleLookupState> {
  VehicleLookupCubit() : super(const VehicleLookupState());

  static const List<Map<String, String>> _debugMockItems = [
    {'vehicleNo': 'GJ05 AB 4589', 'owner': 'Suresh Patel', 'flat': 'A-101'},
    {'vehicleNo': 'GJ05 CD 1023', 'owner': 'Ramesh Shah', 'flat': 'B-203'},
    {'vehicleNo': 'GJ05 EF 7742', 'owner': 'Priya Mehta', 'flat': 'C-305'},
    {'vehicleNo': 'GJ05 GH 2291', 'owner': 'Amit Desai', 'flat': 'A-402'},
    {'vehicleNo': 'GJ05 JK 6635', 'owner': 'Neha Joshi', 'flat': 'B-110'},
    {'vehicleNo': 'GJ05 LM 8890', 'owner': 'Karan Singh', 'flat': 'C-201'},
  ];

  List<Map<String, String>> get _allItems {
    if (AppConstants.useMockData) {
      return _debugMockItems;
    }
    return [];
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  List<Map<String, String>> filteredItems() {
    final query = state.searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _allItems;
    }
    return _allItems.where((item) {
      final vehicle = (item['vehicleNo'] ?? '').toLowerCase();
      final owner = (item['owner'] ?? '').toLowerCase();
      final flat = (item['flat'] ?? '').toLowerCase();
      return vehicle.contains(query) ||
          owner.contains(query) ||
          flat.contains(query);
    }).toList();
  }
}
