import 'package:society_managment/society_management.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<DirectoryCubit>(
      create: (_) => DirectoryCubit(),
      child: const DirectoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: BlocBuilder<DirectoryCubit, DirectoryState>(
        builder: (context, state) {
          final cubit = context.read<DirectoryCubit>();
          final residents = cubit.filteredResidents();

          return Column(
            children: [
              // App Bar
              Container(
                width: double.infinity,
                color: AppColors.blue,
                padding: EdgeInsets.fromLTRB(
                  AppConstants.horizontalPadding,
                  MediaQuery.of(context).padding.top + 14.h,
                  AppConstants.horizontalPadding,
                  14.h,
                ),
                child: Text(
                  l10n?.directory ?? "",
                  style: styleW700S24.copyWith(color: AppColors.white),
                ),
              ),

              Expanded(
                child: CustomSingleChildScroll(
                  padding: EdgeInsets.fromLTRB(
                    AppConstants.horizontalPadding,
                    20.h,
                    AppConstants.horizontalPadding,
                    14.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonFilterChipRow(
                        labels: [
                          l10n?.allWing ?? '',
                          l10n?.wingA ?? '',
                          l10n?.wingB ?? '',
                          l10n?.wingC ?? '',
                        ],
                        selectedIndex: state.filter.index,
                        onSelected: (index) => cubit.onFilterChanged(
                          DirectoryFilter.values[index],
                        ),
                      ),

                      20.h.spaceVertical,

                      AppSearchBar(
                        hintText: l10n?.directorySearchHint ?? "",
                        onChanged: cubit.onSearchChanged,
                      ),

                      16.h.spaceVertical,

                      if (residents.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 160.h),
                            child: Text(
                              l10n?.noResidentsAvailable ?? "",
                              style: styleW400S16.copyWith(
                                color: AppColors.text.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          padding: .zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: residents.length,
                          separatorBuilder: (_, _) => 10.h.spaceVertical,
                          itemBuilder: (_, index) {
                            final item = residents[index];
                            return _ResidentCard(
                              onTap: () => cubit.onResidentTap(context, item),
                              name: item['name'] ?? '',
                              flat: item['flat'] ?? '',
                              mobile: item['mobile'] ?? '',
                              vehicle: item['vehicle'] ?? '',
                              profession: item['profession'] ?? '',
                              members: item['members'] ?? '0',
                              l10n: l10n,
                            );
                          },
                        ),
                    ],
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

class _ResidentCard extends StatelessWidget {
  const _ResidentCard({
    required this.onTap,
    required this.name,
    required this.flat,
    required this.mobile,
    required this.vehicle,
    required this.profession,
    required this.members,
    required this.l10n,
  });

  final VoidCallback onTap;
  final String name;
  final String flat;
  final String mobile;
  final String vehicle;
  final String profession;
  final String members;
  final AppLocalizations? l10n;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: AssetsImg(
                      imagePath: AppAssets.defaultProfileImg,
                      fit: BoxFit.cover,
                      width: 44.w,
                      height: 44.w,
                    ),
                  ),

                  10.w.spaceHorizontal,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: styleW500S16),

                        4.h.spaceVertical,

                        Text(
                          flat,
                          style: styleW400S14.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      '$members ${l10n?.member ?? ""}',
                      style: styleW500S12.copyWith(color: AppColors.darkBlue),
                    ),
                  ),
                ],
              ),

              10.h.spaceVertical,

              CommonDivider(),

              10.h.spaceVertical,

              Row(
                children: [
                  Expanded(
                    child: _InfoColumn(
                      label: l10n?.mobile ?? "",
                      value: mobile,
                    ),
                  ),
                  Expanded(
                    child: _InfoColumn(
                      label: l10n?.vehicle ?? "",
                      value: vehicle,
                    ),
                  ),
                  Expanded(
                    child: _InfoColumn(
                      label: l10n?.profession ?? "",
                      value: profession,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: styleW400S14.copyWith(
            color: AppColors.text.withValues(alpha: 0.6),
          ),
        ),

        4.h.spaceVertical,

        Text(value, style: styleW500S14),
      ],
    );
  }
}
