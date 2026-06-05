import 'package:society_managment/society_managment.dart';

class VehicleLookupScreen extends StatelessWidget {
  const VehicleLookupScreen({super.key});

  static const routeName = '/vehicle_lookup';

  static Widget builder(BuildContext context) {
    return BlocProvider<VehicleLookupCubit>(
      create: (_) => VehicleLookupCubit(),
      child: const VehicleLookupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.vehicleLookup ?? "",
        color: AppColors.blue,
        centerTitle: false,
        systemUiStyle: .light,
        titleStyle: styleW600S24.copyWith(color: AppColors.white),
      ),
      body: BlocBuilder<VehicleLookupCubit, VehicleLookupState>(
        builder: (context, state) {
          final cubit = context.read<VehicleLookupCubit>();
          final items = cubit.filteredItems();

          return Column(
            children: [
              Padding(
                padding: .fromLTRB(
                  AppConstants.horizontalPadding,
                  16.h,
                  AppConstants.horizontalPadding,
                  0.h,
                ),
                child: AppSearchBar(
                  hintText: l10n?.searchVehicleHint ?? "",
                  onChanged: cubit.onSearchChanged,
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          l10n?.noVehiclesAvailable ?? "",
                          style: styleW400S16.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : Container(
                        margin: .all(AppConstants.horizontalPadding),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.text.withValues(alpha: 0.05),
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: .symmetric(vertical: 4.h),
                          itemCount: items.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: .symmetric(horizontal: 14.w),
                            child: CommonDivider(
                              color: AppColors.text.withValues(alpha: 0.1),
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final item = items[index];

                            return ListTile(
                              contentPadding: .symmetric(
                                horizontal: 14.w,
                                vertical: 4.h,
                              ),
                              leading: ClipOval(
                                child: (item['image'] ?? '').isNotEmpty
                                    ? CachedImage(
                                        item['image'] ?? '',
                                        skipBaseUrl: true,
                                        fit: .cover,
                                        height: 48.w,
                                        width: 48.w,
                                      )
                                    : AssetsImg(
                                        imagePath: AppAssets.defaultProfileImg,
                                        fit: .cover,
                                        height: 48.w,
                                        width: 48.w,
                                      ),
                              ),
                              title: Text(
                                item['vehicleNo'] ?? '',
                                style: styleW500S16,
                              ),
                              subtitle: Text(
                                '${item['owner'] ?? ''} - ${item['flat'] ?? ''}',
                                style: styleW400S14.copyWith(
                                  color: AppColors.text.withValues(alpha: 0.6),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
