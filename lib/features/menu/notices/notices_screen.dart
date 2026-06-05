import 'package:society_managment/society_managment.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  static const routeName = '/notices';

  static Widget builder(BuildContext context) {
    return const NoticesScreen();
  }

  /// API-driven list — replace when backend is connected.
  List<Map<String, String>> get _items {
    if (AppConstants.useMockData) {
      return _debugMockItems;
    }
    return [];
  }

  static const List<Map<String, String>> _debugMockItems = [
    {
      'title': 'Power Outage Notice – May 2',
      'description':
          'No electricity from 2PM–5PM due to maintenance work. Please plan accordingly.',
      'metaLeft': 'Admin · May 1',
      'metaRight': 'All Wings',
    },
    {
      'title': 'Water Tank Cleaning – May 6',
      'description':
          'Tank cleaning scheduled. Water supply will be paused from 10 AM to 2 PM.',
      'metaLeft': 'Admin · May 4',
      'metaRight': 'All Wings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = _items;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.notices ?? "",
        color: AppColors.blue,
        centerTitle: false,
        systemUiStyle: .light,
        titleStyle: styleW600S24.copyWith(color: AppColors.white),
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                l10n?.noNoticesAvailable ?? "",
                style: styleW400S16.copyWith(
                  color: AppColors.text.withValues(alpha: 0.6),
                ),
              ),
            )
          : ListView.separated(
              padding: .all(AppConstants.horizontalPadding),
              itemCount: items.length,
              separatorBuilder: (_, _) => 12.h.spaceVertical,
              itemBuilder: (context, index) {
                final item = items[index];
                return AlertNoticeCard(
                  title: item['title'] ?? '',
                  description: item['description'] ?? '',
                  metaLeft: item['metaLeft'] ?? '',
                  metaRight: item['metaRight'] ?? '',
                );
              },
            ),
    );
  }
}
