import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
  ];

  /// No description provided for @society_management.
  ///
  /// In en, this message translates to:
  /// **'Society management'**
  String get society_management;

  /// No description provided for @society_management_k.
  ///
  /// In en, this message translates to:
  /// **'SOCIETY MANAGEMENT'**
  String get society_management_k;

  /// No description provided for @manageEverythingInOnePlace.
  ///
  /// In en, this message translates to:
  /// **'Manage Everything in One Place.'**
  String get manageEverythingInOnePlace;

  /// No description provided for @onBoardingContent.
  ///
  /// In en, this message translates to:
  /// **'From maintenance to visitors, handle all society tasks effortlessly. Approve guests instantly and track every entry with ease. Pay dues, track history, and stay updated with clear records.'**
  String get onBoardingContent;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @loginContent.
  ///
  /// In en, this message translates to:
  /// **'Login to manage your society activities seamlessly.'**
  String get loginContent;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @phoneNumberIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberIsRequired;

  /// No description provided for @phoneNumberIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get phoneNumberIsInvalid;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @otpSentMessagePrefix.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to '**
  String get otpSentMessagePrefix;

  /// No description provided for @otpSentMessageSuffix.
  ///
  /// In en, this message translates to:
  /// **'\nIt may take a minute to arrive.'**
  String get otpSentMessageSuffix;

  /// No description provided for @didntYouReceiveAnyCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t you receive any code?'**
  String get didntYouReceiveAnyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in'**
  String get resendCodeIn;

  /// No description provided for @verifyContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify & Continue'**
  String get verifyContinue;

  /// No description provided for @otpIsRequired.
  ///
  /// In en, this message translates to:
  /// **'OTP is required'**
  String get otpIsRequired;

  /// No description provided for @otpIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 6-digit OTP'**
  String get otpIsInvalid;

  /// No description provided for @otpSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get otpSentSuccess;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @directory.
  ///
  /// In en, this message translates to:
  /// **'Directory'**
  String get directory;

  /// No description provided for @allWing.
  ///
  /// In en, this message translates to:
  /// **'All Wing'**
  String get allWing;

  /// No description provided for @wingA.
  ///
  /// In en, this message translates to:
  /// **'Wing A'**
  String get wingA;

  /// No description provided for @wingB.
  ///
  /// In en, this message translates to:
  /// **'Wing B'**
  String get wingB;

  /// No description provided for @wingC.
  ///
  /// In en, this message translates to:
  /// **'Wing C'**
  String get wingC;

  /// No description provided for @directorySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Name, Flat, Mobile Number...'**
  String get directorySearchHint;

  /// No description provided for @noResidentsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No residents available'**
  String get noResidentsAvailable;

  /// No description provided for @member.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get member;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @contactResident.
  ///
  /// In en, this message translates to:
  /// **'Contact Resident'**
  String get contactResident;

  /// No description provided for @wingFlatNumber.
  ///
  /// In en, this message translates to:
  /// **'Wing & Flat Number'**
  String get wingFlatNumber;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @familyMember.
  ///
  /// In en, this message translates to:
  /// **'Family Member'**
  String get familyMember;

  /// No description provided for @moveInDate.
  ///
  /// In en, this message translates to:
  /// **'Move In Date'**
  String get moveInDate;

  /// No description provided for @vehicleNo.
  ///
  /// In en, this message translates to:
  /// **'Vehicle No'**
  String get vehicleNo;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @residentType.
  ///
  /// In en, this message translates to:
  /// **'Resident Type'**
  String get residentType;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profession;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @visitor.
  ///
  /// In en, this message translates to:
  /// **'Visitor'**
  String get visitor;

  /// No description provided for @visitorSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Name, Flat No...'**
  String get visitorSearchHint;

  /// No description provided for @todayVisitor.
  ///
  /// In en, this message translates to:
  /// **'Today Visitor'**
  String get todayVisitor;

  /// No description provided for @otherVisitor.
  ///
  /// In en, this message translates to:
  /// **'Other Visitor'**
  String get otherVisitor;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @called.
  ///
  /// In en, this message translates to:
  /// **'Called'**
  String get called;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// No description provided for @visitorHistory.
  ///
  /// In en, this message translates to:
  /// **'Visitor History'**
  String get visitorHistory;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRange;

  /// No description provided for @visitorStatus.
  ///
  /// In en, this message translates to:
  /// **'Visitor Status'**
  String get visitorStatus;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get last7Days;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get last30Days;

  /// No description provided for @customRange.
  ///
  /// In en, this message translates to:
  /// **'Custom Range'**
  String get customRange;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @wingD.
  ///
  /// In en, this message translates to:
  /// **'Wing D'**
  String get wingD;

  /// No description provided for @noVisitorsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No visitors available'**
  String get noVisitorsAvailable;

  /// No description provided for @addVisitor.
  ///
  /// In en, this message translates to:
  /// **'Add Visitor'**
  String get addVisitor;

  /// No description provided for @upcomingVisitorBooking.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Visitor Booking'**
  String get upcomingVisitorBooking;

  /// No description provided for @visitorPicture.
  ///
  /// In en, this message translates to:
  /// **'Visitor Picture'**
  String get visitorPicture;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @visitorName.
  ///
  /// In en, this message translates to:
  /// **'Visitor Name'**
  String get visitorName;

  /// No description provided for @enterVisitorName.
  ///
  /// In en, this message translates to:
  /// **'Enter Visitor Name'**
  String get enterVisitorName;

  /// No description provided for @visitingWing.
  ///
  /// In en, this message translates to:
  /// **'Visiting Wing'**
  String get visitingWing;

  /// No description provided for @selectVisitingWing.
  ///
  /// In en, this message translates to:
  /// **'Select Visiting Wing'**
  String get selectVisitingWing;

  /// No description provided for @visitingFlat.
  ///
  /// In en, this message translates to:
  /// **'Visiting Flat'**
  String get visitingFlat;

  /// No description provided for @selectVisitingFlat.
  ///
  /// In en, this message translates to:
  /// **'Select Visiting Flat'**
  String get selectVisitingFlat;

  /// No description provided for @selectPurpose.
  ///
  /// In en, this message translates to:
  /// **'Select Purpose'**
  String get selectPurpose;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @dashboardSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Name, Flat No, Vehicle No...'**
  String get dashboardSearchHint;

  /// No description provided for @notices.
  ///
  /// In en, this message translates to:
  /// **'Notices'**
  String get notices;

  /// No description provided for @emergencyAlerts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Alerts'**
  String get emergencyAlerts;

  /// No description provided for @complaints.
  ///
  /// In en, this message translates to:
  /// **'Complains'**
  String get complaints;

  /// No description provided for @noComplaintsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No complaints available'**
  String get noComplaintsAvailable;

  /// No description provided for @addComplain.
  ///
  /// In en, this message translates to:
  /// **'New Complain'**
  String get addComplain;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @assignToStaff.
  ///
  /// In en, this message translates to:
  /// **'Assign to Staff'**
  String get assignToStaff;

  /// No description provided for @assign.
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get assign;

  /// No description provided for @banquetHall.
  ///
  /// In en, this message translates to:
  /// **'Banquet Hall'**
  String get banquetHall;

  /// No description provided for @hallBooking.
  ///
  /// In en, this message translates to:
  /// **'Hall Booking'**
  String get hallBooking;

  /// No description provided for @totalBooking.
  ///
  /// In en, this message translates to:
  /// **'Total Booking'**
  String get totalBooking;

  /// No description provided for @totalEarning.
  ///
  /// In en, this message translates to:
  /// **'Total Earning'**
  String get totalEarning;

  /// No description provided for @booked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get booked;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @purpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// No description provided for @noBookingsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No bookings available'**
  String get noBookingsAvailable;

  /// No description provided for @vehicleLookup.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Lookup'**
  String get vehicleLookup;

  /// No description provided for @searchVehicleHint.
  ///
  /// In en, this message translates to:
  /// **'Search Vehicle...'**
  String get searchVehicleHint;

  /// No description provided for @noVehiclesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No vehicles found'**
  String get noVehiclesAvailable;

  /// No description provided for @createNewUser.
  ///
  /// In en, this message translates to:
  /// **'Create New User'**
  String get createNewUser;

  /// No description provided for @newComplain.
  ///
  /// In en, this message translates to:
  /// **'New Complain'**
  String get newComplain;

  /// No description provided for @bookBanquetHall.
  ///
  /// In en, this message translates to:
  /// **'Book Banquet Hall'**
  String get bookBanquetHall;

  /// No description provided for @createUser.
  ///
  /// In en, this message translates to:
  /// **'Create User'**
  String get createUser;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get enterName;

  /// No description provided for @flatNoLocation.
  ///
  /// In en, this message translates to:
  /// **'Flat No / Location'**
  String get flatNoLocation;

  /// No description provided for @enterFlatNoLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter Flat Number / Location'**
  String get enterFlatNoLocation;

  /// No description provided for @complaintTitle.
  ///
  /// In en, this message translates to:
  /// **'Complaint Title'**
  String get complaintTitle;

  /// No description provided for @enterComplaintTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Complaint Title'**
  String get enterComplaintTitle;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @selectPriority.
  ///
  /// In en, this message translates to:
  /// **'Select Priority'**
  String get selectPriority;

  /// No description provided for @submitComplaint.
  ///
  /// In en, this message translates to:
  /// **'Submit Complaint'**
  String get submitComplaint;

  /// No description provided for @wing.
  ///
  /// In en, this message translates to:
  /// **'Wing'**
  String get wing;

  /// No description provided for @selectWing.
  ///
  /// In en, this message translates to:
  /// **'Select Wing'**
  String get selectWing;

  /// No description provided for @flat.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get flat;

  /// No description provided for @selectFlat.
  ///
  /// In en, this message translates to:
  /// **'Select Flat'**
  String get selectFlat;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Role'**
  String get selectRole;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumber;

  /// No description provided for @enterContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Contact Number'**
  String get enterContactNumber;

  /// No description provided for @purposeOfBooking.
  ///
  /// In en, this message translates to:
  /// **'Purpose of Booking'**
  String get purposeOfBooking;

  /// No description provided for @selectPurposeOfBooking.
  ///
  /// In en, this message translates to:
  /// **'Select Purpose of Booking'**
  String get selectPurposeOfBooking;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount;

  /// No description provided for @fieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldIsRequired;

  /// No description provided for @amountIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Amount must contain only numbers'**
  String get amountIsInvalid;

  /// No description provided for @pastDateNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Past dates are not allowed'**
  String get pastDateNotAllowed;

  /// No description provided for @endDateBeforeStartDate.
  ///
  /// In en, this message translates to:
  /// **'End date can\'t be before start date'**
  String get endDateBeforeStartDate;

  /// No description provided for @noNoticesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No notices available'**
  String get noNoticesAvailable;

  /// No description provided for @noEmergencyAlertsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No emergency alerts available'**
  String get noEmergencyAlertsAvailable;

  /// No description provided for @father.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get father;

  /// No description provided for @mother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// No description provided for @son.
  ///
  /// In en, this message translates to:
  /// **'Son'**
  String get son;

  /// No description provided for @daughter.
  ///
  /// In en, this message translates to:
  /// **'Daughter'**
  String get daughter;

  /// No description provided for @brother.
  ///
  /// In en, this message translates to:
  /// **'Brother'**
  String get brother;

  /// No description provided for @sister.
  ///
  /// In en, this message translates to:
  /// **'Sister'**
  String get sister;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOut;

  /// No description provided for @logOutContent.
  ///
  /// In en, this message translates to:
  /// **'You will be logged out of your account and need to sign in again to continue.'**
  String get logOutContent;

  /// No description provided for @yesLogout.
  ///
  /// In en, this message translates to:
  /// **'Yes, Logout'**
  String get yesLogout;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @youWantToExitTheApp.
  ///
  /// In en, this message translates to:
  /// **'You want to exit the app'**
  String get youWantToExitTheApp;

  /// No description provided for @yesExitNow.
  ///
  /// In en, this message translates to:
  /// **'Yes, Exit Now'**
  String get yesExitNow;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get pageNotFound;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet'**
  String get noInternet;

  /// No description provided for @noInternetDescription.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet and refresh the page to continue.'**
  String get noInternetDescription;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @familyMembers.
  ///
  /// In en, this message translates to:
  /// **'Family Members'**
  String get familyMembers;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicle;

  /// No description provided for @enterOccupation.
  ///
  /// In en, this message translates to:
  /// **'Enter Occupation'**
  String get enterOccupation;

  /// No description provided for @enterVehicleNo.
  ///
  /// In en, this message translates to:
  /// **'Enter Vehicle No'**
  String get enterVehicleNo;

  /// No description provided for @selectResidentType.
  ///
  /// In en, this message translates to:
  /// **'Select Resident Type'**
  String get selectResidentType;

  /// No description provided for @tenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get tenant;

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMember;

  /// No description provided for @editMember.
  ///
  /// In en, this message translates to:
  /// **'Edit Member'**
  String get editMember;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Full Name'**
  String get enterFullName;

  /// No description provided for @selectOccupation.
  ///
  /// In en, this message translates to:
  /// **'Select Occupation'**
  String get selectOccupation;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// No description provided for @selectRelation.
  ///
  /// In en, this message translates to:
  /// **'Select Relation'**
  String get selectRelation;

  /// No description provided for @deleteMember.
  ///
  /// In en, this message translates to:
  /// **'Delete Member'**
  String get deleteMember;

  /// No description provided for @deleteMemberContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this family member.'**
  String get deleteMemberContent;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get yesDelete;

  /// No description provided for @noFamilyMembersAvailable.
  ///
  /// In en, this message translates to:
  /// **'No family members added yet'**
  String get noFamilyMembersAvailable;

  /// No description provided for @enterVehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Vehicle Number'**
  String get enterVehicleNumber;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @netBalance.
  ///
  /// In en, this message translates to:
  /// **'NET BALANCE'**
  String get netBalance;

  /// No description provided for @vsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'vs Last Month'**
  String get vsLastMonth;

  /// No description provided for @totalIncome.
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get totalIncome;

  /// No description provided for @totalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get totalExpenses;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get selectMonth;

  /// No description provided for @maintenanceSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Transactions, Flats, Categories...'**
  String get maintenanceSearchHint;

  /// No description provided for @fundOverview.
  ///
  /// In en, this message translates to:
  /// **'Fund Overview'**
  String get fundOverview;

  /// No description provided for @monthlyTrends.
  ///
  /// In en, this message translates to:
  /// **'Monthly Trends'**
  String get monthlyTrends;

  /// No description provided for @maintenanceCollected.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Collected'**
  String get maintenanceCollected;

  /// No description provided for @festivalFund.
  ///
  /// In en, this message translates to:
  /// **'Festival Fund'**
  String get festivalFund;

  /// No description provided for @otherIncome.
  ///
  /// In en, this message translates to:
  /// **'Other Income'**
  String get otherIncome;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @noTransactionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No transactions available'**
  String get noTransactionsAvailable;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @transferFees.
  ///
  /// In en, this message translates to:
  /// **'Transfer Fees'**
  String get transferFees;

  /// No description provided for @securityGuard.
  ///
  /// In en, this message translates to:
  /// **'Security Guard'**
  String get securityGuard;

  /// No description provided for @netMaintenance.
  ///
  /// In en, this message translates to:
  /// **'NET MAINTENANCE'**
  String get netMaintenance;

  /// No description provided for @pendingMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Pending Maintenance'**
  String get pendingMaintenance;

  /// No description provided for @expectedMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Expected Maintenance'**
  String get expectedMaintenance;

  /// No description provided for @memberList.
  ///
  /// In en, this message translates to:
  /// **'Member List'**
  String get memberList;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @addExpenses.
  ///
  /// In en, this message translates to:
  /// **'Add Expenses'**
  String get addExpenses;

  /// No description provided for @addIncome.
  ///
  /// In en, this message translates to:
  /// **'Add Income'**
  String get addIncome;

  /// No description provided for @addMaintenanceReminder.
  ///
  /// In en, this message translates to:
  /// **'Add Maintenance Reminder'**
  String get addMaintenanceReminder;

  /// No description provided for @maintenanceAmount.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Amount'**
  String get maintenanceAmount;

  /// No description provided for @enterMaintenanceAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Maintenance Amount'**
  String get enterMaintenanceAmount;

  /// No description provided for @billingMonth.
  ///
  /// In en, this message translates to:
  /// **'Billing Month'**
  String get billingMonth;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @typeHere.
  ///
  /// In en, this message translates to:
  /// **'Type Here...'**
  String get typeHere;

  /// No description provided for @generateMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Generate Maintenance'**
  String get generateMaintenance;

  /// No description provided for @incomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Income Title'**
  String get incomeTitle;

  /// No description provided for @enterIncomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Income Title'**
  String get enterIncomeTitle;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @receivedFrom.
  ///
  /// In en, this message translates to:
  /// **'Received From'**
  String get receivedFrom;

  /// No description provided for @selectPerson.
  ///
  /// In en, this message translates to:
  /// **'Select Person'**
  String get selectPerson;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// No description provided for @expenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense Title'**
  String get expenseTitle;

  /// No description provided for @enterExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Expense Title'**
  String get enterExpenseTitle;

  /// No description provided for @paidTo.
  ///
  /// In en, this message translates to:
  /// **'Paid To'**
  String get paidTo;

  /// No description provided for @fireDrillTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'Fire Drill Today At 6 PM'**
  String get fireDrillTodayTitle;

  /// No description provided for @fireDrillTodaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Assemble At Ground Floor Parking • All Wings'**
  String get fireDrillTodaySubtitle;

  /// No description provided for @societyOverview.
  ///
  /// In en, this message translates to:
  /// **'Society Overview'**
  String get societyOverview;

  /// No description provided for @totalFlats.
  ///
  /// In en, this message translates to:
  /// **'Total Flats'**
  String get totalFlats;

  /// No description provided for @totalResidents.
  ///
  /// In en, this message translates to:
  /// **'Total Residents'**
  String get totalResidents;

  /// No description provided for @totalComplaints.
  ///
  /// In en, this message translates to:
  /// **'Total Complains'**
  String get totalComplaints;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @recentComplaints.
  ///
  /// In en, this message translates to:
  /// **'Recent Complaints'**
  String get recentComplaints;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning!'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon!'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening!'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night!'**
  String get goodNight;

  /// No description provided for @toastError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get toastError;

  /// No description provided for @toastSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get toastSuccess;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get unexpectedError;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout'**
  String get connectionTimeout;

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled'**
  String get requestCancelled;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error occurred'**
  String get networkError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error occurred'**
  String get serverError;

  /// No description provided for @checkInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection!'**
  String get checkInternetConnection;

  /// No description provided for @defaultUserName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get defaultUserName;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'-'**
  String get notAvailable;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @societyAdmin.
  ///
  /// In en, this message translates to:
  /// **'Society Admin'**
  String get societyAdmin;

  /// No description provided for @paymentCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentCash;

  /// No description provided for @paymentUpi.
  ///
  /// In en, this message translates to:
  /// **'UPI'**
  String get paymentUpi;

  /// No description provided for @paymentBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get paymentBankTransfer;

  /// No description provided for @paymentCheque.
  ///
  /// In en, this message translates to:
  /// **'Cheque'**
  String get paymentCheque;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @utilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get utilities;

  /// No description provided for @repairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get repairs;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendor;

  /// No description provided for @purposeBirthdayCelebration.
  ///
  /// In en, this message translates to:
  /// **'Birthday Celebration'**
  String get purposeBirthdayCelebration;

  /// No description provided for @purposeEngagementFunction.
  ///
  /// In en, this message translates to:
  /// **'Engagement Function'**
  String get purposeEngagementFunction;

  /// No description provided for @purposeSocietyMeeting.
  ///
  /// In en, this message translates to:
  /// **'Society Meeting'**
  String get purposeSocietyMeeting;

  /// No description provided for @purposeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get purposeDelivery;

  /// No description provided for @purposeGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get purposeGuest;

  /// No description provided for @purposeService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get purposeService;

  /// No description provided for @purposePersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get purposePersonal;

  /// No description provided for @occupationAccountant.
  ///
  /// In en, this message translates to:
  /// **'Accountant'**
  String get occupationAccountant;

  /// No description provided for @occupationEngineer.
  ///
  /// In en, this message translates to:
  /// **'Engineer'**
  String get occupationEngineer;

  /// No description provided for @occupationDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get occupationDoctor;

  /// No description provided for @occupationTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get occupationTeacher;

  /// No description provided for @occupationLawyer.
  ///
  /// In en, this message translates to:
  /// **'Lawyer'**
  String get occupationLawyer;

  /// No description provided for @occupationBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get occupationBusiness;

  /// No description provided for @occupationStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get occupationStudent;

  /// No description provided for @occupationHomemaker.
  ///
  /// In en, this message translates to:
  /// **'Homemaker'**
  String get occupationHomemaker;

  /// No description provided for @languageEnglishUS.
  ///
  /// In en, this message translates to:
  /// **'English (United States)'**
  String get languageEnglishUS;

  /// No description provided for @languageGujarati.
  ///
  /// In en, this message translates to:
  /// **'Gujarati'**
  String get languageGujarati;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get languageHindi;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'days ago,'**
  String get daysAgo;

  /// No description provided for @weekdaySun.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get weekdaySun;

  /// No description provided for @weekdayMon.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get weekdaySat;

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @allWings.
  ///
  /// In en, this message translates to:
  /// **'All Wings'**
  String get allWings;

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad request'**
  String get badRequest;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get sessionExpired;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get accessDenied;

  /// No description provided for @resourceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Resource not found'**
  String get resourceNotFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'gu', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
