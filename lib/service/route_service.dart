import 'package:society_managment/society_managment.dart';

class RouteService {
  static String get initialRoute => SplashScreen.routeName;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// Splash
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: SplashScreen.builder,
          settings: settings,
        );

      /// OnBoarding
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          builder: OnboardingScreen.builder,
          settings: settings,
        );

      /// Sign In
      case SignInScreen.routeName:
        return MaterialPageRoute(
          builder: SignInScreen.builder,
          settings: settings,
        );

      /// OTP Verification
      case OtpVerificationScreen.routeName:
        return MaterialPageRoute(
          builder: OtpVerificationScreen.builder,
          settings: settings,
        );

      /// Notices
      case NoticesScreen.routeName:
        return MaterialPageRoute(
          builder: NoticesScreen.builder,
          settings: settings,
        );

      /// Emergency Alerts
      case EmergencyAlertsScreen.routeName:
        return MaterialPageRoute(
          builder: EmergencyAlertsScreen.builder,
          settings: settings,
        );

      /// Vehicle Lookup
      case VehicleLookupScreen.routeName:
        return MaterialPageRoute(
          builder: VehicleLookupScreen.builder,
          settings: settings,
        );

      /// Resident Details
      case ResidentDetailsScreen.routeName:
        return MaterialPageRoute(
          builder: ResidentDetailsScreen.builder,
          settings: settings,
        );

      /// Complaints
      case ComplaintsScreen.routeName:
        return MaterialPageRoute(
          builder: ComplaintsScreen.builder,
          settings: settings,
        );

      /// Add Complain
      case AddComplainScreen.routeName:
        return MaterialPageRoute(
          builder: AddComplainScreen.builder,
          settings: settings,
        );

      /// Banquet Hall
      case BanquetHallScreen.routeName:
        return MaterialPageRoute(
          builder: BanquetHallScreen.builder,
          settings: settings,
        );

      /// Book Banquet Hall
      case BookBanquetHallScreen.routeName:
        return MaterialPageRoute(
          builder: BookBanquetHallScreen.builder,
          settings: settings,
        );

      /// Create New User
      case CreateNewUserScreen.routeName:
        return MaterialPageRoute(
          builder: CreateNewUserScreen.builder,
          settings: settings,
        );

      /// Dashboard
      case DashboardScreen.routeName:
        return MaterialPageRoute(
          builder: DashboardScreen.builder,
          settings: settings,
        );

      /// Setting
      case SettingScreen.routeName:
        return MaterialPageRoute(
          builder: SettingScreen.builder,
          settings: settings,
        );

      /// Language
      case LanguageScreen.routeName:
        return MaterialPageRoute(
          builder: LanguageScreen.builder,
          settings: settings,
        );

      /// My Profile
      case MyProfileScreen.routeName:
        return MaterialPageRoute(
          builder: MyProfileScreen.builder,
          settings: settings,
        );

      /// Edit Profile
      case EditProfileScreen.routeName:
        return MaterialPageRoute(
          builder: EditProfileScreen.builder,
          settings: settings,
        );

      /// Family Members
      case FamilyMembersScreen.routeName:
        return MaterialPageRoute(
          builder: FamilyMembersScreen.builder,
          settings: settings,
        );

      /// Add Family Member
      case AddFamilyMemberScreen.routeName:
        return MaterialPageRoute(
          builder: AddFamilyMemberScreen.builder,
          settings: settings,
        );

      /// Guard Add Visitor
      case GuardAddVisitorScreen.routeName:
        return MaterialPageRoute(
          builder: GuardAddVisitorScreen.builder,
          settings: settings,
        );

      /// User Add Visitor
      case UserAddVisitorScreen.routeName:
        return MaterialPageRoute(
          builder: UserAddVisitorScreen.builder,
          settings: settings,
        );

      /// Add Maintenance Reminder
      case AddMaintenanceReminderScreen.routeName:
        return MaterialPageRoute(
          builder: AddMaintenanceReminderScreen.builder,
          settings: settings,
        );

      /// Add Income
      case AddIncomeScreen.routeName:
        return MaterialPageRoute(
          builder: AddIncomeScreen.builder,
          settings: settings,
        );

      /// Add Expense
      case AddExpenseScreen.routeName:
        return MaterialPageRoute(
          builder: AddExpenseScreen.builder,
          settings: settings,
        );

      /// Transaction History
      case TransactionHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: TransactionHistoryScreen.builder,
          settings: settings,
        );

      /// Maintenance History
      case MaintenanceHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: MaintenanceHistoryScreen.builder,
          settings: settings,
        );

      /// Visitor History
      case VisitorHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: VisitorHistoryScreen.builder,
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => UnknownScreen(),
          settings: settings,
        );
    }
  }
}
