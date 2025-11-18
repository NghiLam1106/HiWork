import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HiWork'**
  String get appTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to HiWork! - Effective human resource management application'**
  String get welcomeMessage;

  /// No description provided for @loginBtn.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get loginBtn;

  /// No description provided for @registerBtn.
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get registerBtn;

  /// No description provided for @titleLogin.
  ///
  /// In en, this message translates to:
  /// **'Login to'**
  String get titleLogin;

  /// No description provided for @hintTextUsername.
  ///
  /// In en, this message translates to:
  /// **'Username or Email'**
  String get hintTextUsername;

  /// No description provided for @hintTextPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get hintTextPassword;

  /// No description provided for @forgotPasword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPasword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'You do not have an account? '**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @titleRegister.
  ///
  /// In en, this message translates to:
  /// **'Register an account'**
  String get titleRegister;

  /// No description provided for @hintTextFullname.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get hintTextFullname;

  /// No description provided for @hintTextEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get hintTextEmail;

  /// No description provided for @hintTextConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get hintTextConfirmPassword;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Sign in now'**
  String get loginNow;

  /// No description provided for @haveAcconunt.
  ///
  /// In en, this message translates to:
  /// **'You already have an account? '**
  String get haveAcconunt;

  /// No description provided for @titleScan.
  ///
  /// In en, this message translates to:
  /// **'Face scanning'**
  String get titleScan;

  /// No description provided for @titleScanHello.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get titleScanHello;

  /// No description provided for @titleCardJob.
  ///
  /// In en, this message translates to:
  /// **'Work schedule'**
  String get titleCardJob;

  /// No description provided for @titleCardLeave.
  ///
  /// In en, this message translates to:
  /// **'Sign up for leave'**
  String get titleCardLeave;

  /// No description provided for @titleCardMoney.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get titleCardMoney;

  /// No description provided for @titleCardChat.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get titleCardChat;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTask.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get navTask;

  /// No description provided for @navNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get navNotification;

  /// No description provided for @navAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get navAccount;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get taskTitle;

  /// No description provided for @workScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Work Schedule'**
  String get workScheduleTitle;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// No description provided for @nextWeek.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get nextWeek;

  /// No description provided for @previousWeek.
  ///
  /// In en, this message translates to:
  /// **'Previous week'**
  String get previousWeek;

  /// No description provided for @shiftMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning shift'**
  String get shiftMorning;

  /// No description provided for @shiftNoon.
  ///
  /// In en, this message translates to:
  /// **'Noon shift'**
  String get shiftNoon;

  /// No description provided for @shiftEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening shift'**
  String get shiftEvening;

  /// No description provided for @dayOff.
  ///
  /// In en, this message translates to:
  /// **'Day off'**
  String get dayOff;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On time'**
  String get onTime;

  /// No description provided for @leftEarly.
  ///
  /// In en, this message translates to:
  /// **'Left early'**
  String get leftEarly;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get late;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @forgotCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Forgot to check in'**
  String get forgotCheckIn;

  /// No description provided for @notStartedYet.
  ///
  /// In en, this message translates to:
  /// **'Not started yet'**
  String get notStartedYet;

  /// No description provided for @leaveRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave Registration List'**
  String get leaveRegisterTitle;

  /// No description provided for @leaveRegisterMonth.
  ///
  /// In en, this message translates to:
  /// **'Month {month} Year {year}'**
  String leaveRegisterMonth(Object month, Object year);

  /// No description provided for @leaveRegisterHint.
  ///
  /// In en, this message translates to:
  /// **'You can send your leave request here'**
  String get leaveRegisterHint;

  /// No description provided for @registerLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Register for leave'**
  String get registerLeaveTitle;

  /// No description provided for @leaveDate.
  ///
  /// In en, this message translates to:
  /// **'Leave date'**
  String get leaveDate;

  /// No description provided for @selectShift.
  ///
  /// In en, this message translates to:
  /// **'Select shift'**
  String get selectShift;

  /// No description provided for @reasonLeave.
  ///
  /// In en, this message translates to:
  /// **'Reason for leave'**
  String get reasonLeave;

  /// No description provided for @submitLeaveRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit leave request'**
  String get submitLeaveRequest;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @taskScheduleCommon.
  ///
  /// In en, this message translates to:
  /// **'Common Work Schedule'**
  String get taskScheduleCommon;

  /// No description provided for @taskScheduleRegister.
  ///
  /// In en, this message translates to:
  /// **'Work Schedule Registration'**
  String get taskScheduleRegister;

  /// No description provided for @taskTimeKeepingTitle.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping'**
  String get taskTimeKeepingTitle;

  /// No description provided for @taskAddAndEditAdtendance.
  ///
  /// In en, this message translates to:
  /// **'Add/Edit Timekeeping'**
  String get taskAddAndEditAdtendance;

  /// No description provided for @taskTimeKeepingEquipment.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping Equipment'**
  String get taskTimeKeepingEquipment;

  /// No description provided for @taskSalaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get taskSalaryTitle;

  /// No description provided for @taskSalaryAdvanceSlip.
  ///
  /// In en, this message translates to:
  /// **'Salary Advance Slip'**
  String get taskSalaryAdvanceSlip;

  /// No description provided for @taskSalaryIsOnHold.
  ///
  /// In en, this message translates to:
  /// **'Salary in Hold'**
  String get taskSalaryIsOnHold;

  /// No description provided for @taskAutomaticSalary.
  ///
  /// In en, this message translates to:
  /// **'Automatic Salary Increase Process'**
  String get taskAutomaticSalary;

  /// No description provided for @taskSalaryHistory.
  ///
  /// In en, this message translates to:
  /// **'Automatic Salary Increase History'**
  String get taskSalaryHistory;

  /// No description provided for @taskSalarySlip.
  ///
  /// In en, this message translates to:
  /// **'Salary Slip'**
  String get taskSalarySlip;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationTitle;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation password does not match!'**
  String get passwordConfirm;

  /// No description provided for @companyInformation.
  ///
  /// In en, this message translates to:
  /// **'Information company'**
  String get companyInformation;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logout;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'guest'**
  String get guest;

  /// No description provided for @pleaseSignIn.
  ///
  /// In en, this message translates to:
  /// **'please sign in'**
  String get pleaseSignIn;

  /// No description provided for @confirmLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'confirm logout'**
  String get confirmLogoutTitle;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'confirm you want to logout?'**
  String get confirmLogoutMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirm;

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'logout successful'**
  String get logoutSuccess;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password.'**
  String get invalidCredentials;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error occurred. Please try again later.'**
  String get serverError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error has occurred.'**
  String get unknownError;

  /// No description provided for @authSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Authentication session has expired.'**
  String get authSessionExpired;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid input provided.'**
  String get invalidInput;

  /// No description provided for @notificationsAvailable.
  ///
  /// In en, this message translates to:
  /// **'You have {count} notifications available.'**
  String notificationsAvailable(Object count);

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications available.'**
  String get noNotifications;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
