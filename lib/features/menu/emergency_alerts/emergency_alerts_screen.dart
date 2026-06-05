import 'package:society_managment/society_managment.dart';

class EmergencyAlertsScreen extends StatelessWidget {
  const EmergencyAlertsScreen({super.key});

  static const routeName = '/emergency_alerts';

  static Widget builder(BuildContext context) {
    return const EmergencyAlertsScreen();
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
      'title': 'Fire Drill – Today',
      'description':
          'Assemble at ground floor parking at 6 PM. All residents must attend.',
      'metaLeft': 'Apr 30 · 3:00 PM',
      'metaRight': 'All Wings',
    },
    {
      'title': 'Power Outage – Wing A',
      'description':
          'Electrician notified. Estimated resolution in 1 hour. Please avoid lift usage.',
      'metaLeft': 'Apr 30 · 2:15 PM',
      'metaRight': 'Wing A',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = _items;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: l10n?.emergencyAlerts ?? "",
        color: AppColors.blue,
        centerTitle: false,
        systemUiStyle: .light,
        titleStyle: styleW600S24.copyWith(color: AppColors.white),
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                l10n?.noEmergencyAlertsAvailable ?? "",
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
