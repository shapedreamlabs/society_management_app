import 'package:society_managment/society_management.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _loadDashboardData();
  }

  void refresh(HomeState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onBannerChange(int index) {
    refresh(state.copyWith(currentBanner: index));
  }

  Future<void> _loadDashboardData() async {
    refresh(state.copyWith(loader: true));
  }

  Future<void> onTapViewAllSubmittedResults(BuildContext context) async {}

  Future<void> onTapDeleteResult(
    BuildContext context, {
    required int index,
  }) async {}

  Future<void> onTapUploadResult(BuildContext context) async {}
}
