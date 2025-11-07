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

  /// No description provided for @taskScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Work Schedule'**
  String get taskScheduleTitle;

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

  /// No description provided for @emailError.
  ///
  /// In en, this message translates to:
  /// **'Invalid email!'**
  String get emailError;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters!'**
  String get passwordLength;

  /// No description provided for @passwordConfirm.
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
