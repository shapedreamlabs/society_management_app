import 'package:society_managment/society_management.dart';

part 'directory_state.dart';

enum DirectoryFilter { all, wingA, wingB, wingC }

class DirectoryCubit extends Cubit<DirectoryState> {
  DirectoryCubit() : super(const DirectoryState());

  static const List<Map<String, String>> _debugResidents = [
    {
      'name': 'Nilesh Doshi',
      'flat': 'A-101',
      'mobile': '+91 98745 61234',
      'vehicle': 'GJ 01 AB 1234',
      'profession': 'Accountant',
      'members': '4',
      'wing': 'A',
      'wingFlatNumber': 'A-101',
      'moveInDate': '25 Jan 2025',
      'vehicleNo': 'GJ 05 PS 4262',
      'status': 'Active',
      'residentType': 'Owner',
    },
    {
      'name': 'Rahul Shah',
      'flat': 'A-103',
      'mobile': '99854 00003',
      'vehicle': 'GJ 01 EF 2345',
      'profession': 'Engineer',
      'members': '5',
      'wing': 'A',
      'wingFlatNumber': 'A-103',
      'moveInDate': '10 Feb 2025',
      'vehicleNo': 'GJ 01 EF 2345',
      'status': 'Active',
      'residentType': 'Owner',
    },
    {
      'name': 'Pooja Mehta',
      'flat': 'A-104',
      'mobile': '98955 55454',
      'vehicle': 'GJ 01 GH 3456',
      'profession': 'Doctor',
      'members': '6',
      'wing': 'A',
      'wingFlatNumber': 'A-104',
      'moveInDate': '01 Mar 2025',
      'vehicleNo': 'GJ 01 GH 3456',
      'status': 'Active',
      'residentType': 'Owner',
    },
    {
      'name': 'Karan Patel',
      'flat': 'A-105',
      'mobile': '98712 12345',
      'vehicle': 'GJ 01 JK 4567',
      'profession': 'Lawyer',
      'members': '3',
      'wing': 'A',
      'wingFlatNumber': 'A-105',
      'moveInDate': '12 Apr 2025',
      'vehicleNo': 'GJ 01 JK 4567',
      'status': 'Active',
      'residentType': 'Owner',
    },
  ];

  List<Map<String, String>> get allResidents {
    if (AppConstants.useMockData) return _debugResidents;
    return [];
  }

  void onFilterChanged(DirectoryFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void onResidentTap(BuildContext context, Map<String, String> resident) {
    context.navigator.pushNamed(
      ResidentDetailsScreen.routeName,
      arguments: resident,
    );
  }

  List<Map<String, String>> filteredResidents() {
    Iterable<Map<String, String>> data = allResidents;

    switch (state.filter) {
      case DirectoryFilter.all:
        break;
      case DirectoryFilter.wingA:
        data = data.where((e) => (e['wing'] ?? '') == 'A');
        break;
      case DirectoryFilter.wingB:
        data = data.where((e) => (e['wing'] ?? '') == 'B');
        break;
      case DirectoryFilter.wingC:
        data = data.where((e) => (e['wing'] ?? '') == 'C');
        break;
    }

    final query = state.searchQuery.trim().toLowerCase();
    if (query.isNotEmpty) {
      data = data.where((e) {
        final name = (e['name'] ?? '').toLowerCase();
        final flat = (e['flat'] ?? '').toLowerCase();
        final mobile = (e['mobile'] ?? '').toLowerCase();
        return name.contains(query) ||
            flat.contains(query) ||
            mobile.contains(query);
      });
    }

    return data.toList();
  }
}
