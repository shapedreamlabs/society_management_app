import 'package:society_managment/society_managment.dart';
import 'package:society_managment/society_managment_extra.dart';

abstract class AppLabelKeys {
  static const low = 'low';
  static const medium = 'medium';
  static const high = 'high';
  static const owner = 'owner';
  static const tenant = 'tenant';
  static const family = 'family';
  static const wingA = 'wing_a';
  static const wingB = 'wing_b';
  static const wingC = 'wing_c';
  static const maintenance = 'maintenance';
  static const banquetHall = 'banquet_hall';
  static const festivalFund = 'festival_fund';
  static const other = 'other';
  static const security = 'security';
  static const utilities = 'utilities';
  static const repairs = 'repairs';
  static const transferFees = 'transfer_fees';
  static const securityGuard = 'security_guard';
  static const cash = 'cash';
  static const upi = 'upi';
  static const bankTransfer = 'bank_transfer';
  static const cheque = 'cheque';
  static const societyAdmin = 'society_admin';
  static const vendor = 'vendor';
  static const birthdayCelebration = 'birthday_celebration';
  static const engagementFunction = 'engagement_function';
  static const societyMeeting = 'society_meeting';
  static const delivery = 'delivery';
  static const guest = 'guest';
  static const service = 'service';
  static const personal = 'personal';
  static const accountant = 'accountant';
  static const engineer = 'engineer';
  static const doctor = 'doctor';
  static const teacher = 'teacher';
  static const lawyer = 'lawyer';
  static const business = 'business';
  static const student = 'student';
  static const homemaker = 'homemaker';
  static const active = 'active';
}

class LocalizationLabels {
  LocalizationLabels._();

  static AppLocalizations? _l10n([BuildContext? context]) {
    final ctx = context ?? navigatorKey.currentContext;
    if (ctx == null) return null;
    return AppLocalizations.of(ctx);
  }

  static String greeting(AppLocalizations? l10n) {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return l10n?.goodMorning ?? '';
    }
    if (hour >= 12 && hour < 17) {
      return l10n?.goodAfternoon ?? '';
    }
    if (hour >= 17 && hour < 21) {
      return l10n?.goodEvening ?? '';
    }
    return l10n?.goodNight ?? '';
  }

  static String of(AppLocalizations? l10n, String key) {
    if (l10n == null) return key;

    switch (key) {
      case AppLabelKeys.low:
        return l10n.priorityLow;
      case AppLabelKeys.medium:
        return l10n.priorityMedium;
      case AppLabelKeys.high:
        return l10n.priorityHigh;
      case AppLabelKeys.owner:
        return l10n.owner;
      case AppLabelKeys.tenant:
        return l10n.tenant;
      case AppLabelKeys.family:
        return l10n.family;
      case AppLabelKeys.wingA:
        return l10n.wingA;
      case AppLabelKeys.wingB:
        return l10n.wingB;
      case AppLabelKeys.wingC:
        return l10n.wingC;
      case AppLabelKeys.maintenance:
        return l10n.maintenance;
      case AppLabelKeys.banquetHall:
        return l10n.banquetHall;
      case AppLabelKeys.festivalFund:
        return l10n.festivalFund;
      case AppLabelKeys.other:
        return l10n.other;
      case AppLabelKeys.security:
        return l10n.security;
      case AppLabelKeys.utilities:
        return l10n.utilities;
      case AppLabelKeys.repairs:
        return l10n.repairs;
      case AppLabelKeys.transferFees:
        return l10n.transferFees;
      case AppLabelKeys.securityGuard:
        return l10n.securityGuard;
      case AppLabelKeys.cash:
        return l10n.paymentCash;
      case AppLabelKeys.upi:
        return l10n.paymentUpi;
      case AppLabelKeys.bankTransfer:
        return l10n.paymentBankTransfer;
      case AppLabelKeys.cheque:
        return l10n.paymentCheque;
      case AppLabelKeys.societyAdmin:
        return l10n.societyAdmin;
      case AppLabelKeys.vendor:
        return l10n.vendor;
      case AppLabelKeys.birthdayCelebration:
        return l10n.purposeBirthdayCelebration;
      case AppLabelKeys.engagementFunction:
        return l10n.purposeEngagementFunction;
      case AppLabelKeys.societyMeeting:
        return l10n.purposeSocietyMeeting;
      case AppLabelKeys.delivery:
        return l10n.purposeDelivery;
      case AppLabelKeys.guest:
        return l10n.purposeGuest;
      case AppLabelKeys.service:
        return l10n.purposeService;
      case AppLabelKeys.personal:
        return l10n.purposePersonal;
      case AppLabelKeys.accountant:
        return l10n.occupationAccountant;
      case AppLabelKeys.engineer:
        return l10n.occupationEngineer;
      case AppLabelKeys.doctor:
        return l10n.occupationDoctor;
      case AppLabelKeys.teacher:
        return l10n.occupationTeacher;
      case AppLabelKeys.lawyer:
        return l10n.occupationLawyer;
      case AppLabelKeys.business:
        return l10n.occupationBusiness;
      case AppLabelKeys.student:
        return l10n.occupationStudent;
      case AppLabelKeys.homemaker:
        return l10n.occupationHomemaker;
      case AppLabelKeys.active:
        return l10n.active;
      case 'A':
        return l10n.wingA;
      case 'B':
        return l10n.wingB;
      case 'C':
        return l10n.wingC;
      default:
        return key;
    }
  }

  static String wing(AppLocalizations? l10n, String wing) {
    switch (wing) {
      case 'A':
        return l10n?.wingA ?? wing;
      case 'B':
        return l10n?.wingB ?? wing;
      case 'C':
        return l10n?.wingC ?? wing;
      default:
        return wing;
    }
  }

  static String languageLabel(AppLocalizations? l10n, String code) {
    switch (code) {
      case 'en':
        return l10n?.languageEnglishUS ?? '';
      case 'gu':
        return l10n?.languageGujarati ?? '';
      case 'hi':
        return l10n?.languageHindi ?? '';
      default:
        return l10n?.languageEnglish ?? '';
    }
  }

  static String timePeriod(AppLocalizations? l10n, DayPeriod period) {
    return period == DayPeriod.am ? (l10n?.am ?? '') : (l10n?.pm ?? '');
  }

  static String formatMonthYear(DateTime date, String localeName) {
    return DateFormat('MMMM yyyy', localeName).format(date);
  }

  static String formatMonthYearUpper(DateTime date, String localeName) {
    return formatMonthYear(date, localeName).toUpperCase();
  }

  static List<String> shortMonthLabels(AppLocalizations? l10n) {
    return [
      l10n?.monthJan ?? '',
      l10n?.monthFeb ?? '',
      l10n?.monthMar ?? '',
      l10n?.monthApr ?? '',
      l10n?.monthMay ?? '',
    ];
  }

  static List<String> weekdayLabels(AppLocalizations? l10n) {
    return [
      l10n?.weekdaySun ?? '',
      l10n?.weekdayMon ?? '',
      l10n?.weekdayTue ?? '',
      l10n?.weekdayWed ?? '',
      l10n?.weekdayThu ?? '',
      l10n?.weekdayFri ?? '',
      l10n?.weekdaySat ?? '',
    ];
  }

  static String toastTitle({required bool error, BuildContext? context}) {
    final l10n = _l10n(context);
    return error ? (l10n?.toastError ?? '') : (l10n?.toastSuccess ?? '');
  }

  static String somethingWentWrong([BuildContext? context]) {
    return _l10n(context)?.somethingWentWrong ?? '';
  }

  static String unexpectedError([BuildContext? context]) {
    return _l10n(context)?.unexpectedError ?? '';
  }

  static String noInternetConnection([BuildContext? context]) {
    return _l10n(context)?.noInternetConnection ?? '';
  }

  static String connectionTimeout([BuildContext? context]) {
    return _l10n(context)?.connectionTimeout ?? '';
  }

  static String requestCancelled([BuildContext? context]) {
    return _l10n(context)?.requestCancelled ?? '';
  }

  static String networkError([BuildContext? context]) {
    return _l10n(context)?.networkError ?? '';
  }

  static String serverError([BuildContext? context]) {
    return _l10n(context)?.serverError ?? '';
  }

  static String checkInternetConnection([BuildContext? context]) {
    return _l10n(context)?.checkInternetConnection ?? '';
  }

  static String badRequest([BuildContext? context]) {
    return _l10n(context)?.badRequest ?? '';
  }

  static String sessionExpired([BuildContext? context]) {
    return _l10n(context)?.sessionExpired ?? '';
  }

  static String accessDenied([BuildContext? context]) {
    return _l10n(context)?.accessDenied ?? '';
  }

  static String resourceNotFound([BuildContext? context]) {
    return _l10n(context)?.resourceNotFound ?? '';
  }
}
