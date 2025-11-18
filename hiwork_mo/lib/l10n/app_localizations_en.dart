// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HiWork';

  @override
  String get languageLabel => 'Language';

  @override
  String get welcomeMessage => 'Welcome to HiWork! - Effective human resource management application';

  @override
  String get loginBtn => 'LOGIN';

  @override
  String get registerBtn => 'REGISTER';

  @override
  String get titleLogin => 'Login to';

  @override
  String get hintTextUsername => 'Username or Email';

  @override
  String get hintTextPassword => 'Password';

  @override
  String get forgotPasword => 'Forgot password';

  @override
  String get dontHaveAccount => 'You do not have an account? ';

  @override
  String get registerNow => 'Register now';

  @override
  String get titleRegister => 'Register an account';

  @override
  String get hintTextFullname => 'Full name';

  @override
  String get hintTextEmail => 'Email';

  @override
  String get hintTextConfirmPassword => 'Confirm password';

  @override
  String get loginNow => 'Sign in now';

  @override
  String get haveAcconunt => 'You already have an account? ';

  @override
  String get titleScan => 'Face scanning';

  @override
  String get titleScanHello => 'Hi';

  @override
  String get titleCardJob => 'Work schedule';

  @override
  String get titleCardLeave => 'Sign up for leave';

  @override
  String get titleCardMoney => 'Salary';

  @override
  String get titleCardChat => 'Message';

  @override
  String get navHome => 'Home';

  @override
  String get navTask => 'Task';

  @override
  String get navNotification => 'Notification';

  @override
  String get navAccount => 'Account';

  @override
  String get taskTitle => 'Task';

  @override
  String get workScheduleTitle => 'Work Schedule';

  @override
  String get thisWeek => 'This week';

  @override
  String get nextWeek => 'Next week';

  @override
  String get previousWeek => 'Previous week';

  @override
  String get shiftMorning => 'Morning shift';

  @override
  String get shiftNoon => 'Noon shift';

  @override
  String get shiftEvening => 'Evening shift';

  @override
  String get dayOff => 'Day off';

  @override
  String get onTime => 'On time';

  @override
  String get leftEarly => 'Left early';

  @override
  String get late => 'Late';

  @override
  String get today => 'Today';

  @override
  String get forgotCheckIn => 'Forgot to check in';

  @override
  String get notStartedYet => 'Not started yet';

  @override
  String get leaveRegisterTitle => 'Leave Registration List';

  @override
  String leaveRegisterMonth(Object month, Object year) {
    return 'Month $month Year $year';
  }

  @override
  String get leaveRegisterHint => 'You can send your leave request here';

  @override
  String get registerLeaveTitle => 'Register for leave';

  @override
  String get leaveDate => 'Leave date';

  @override
  String get selectShift => 'Select shift';

  @override
  String get reasonLeave => 'Reason for leave';

  @override
  String get submitLeaveRequest => 'Submit leave request';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get taskScheduleCommon => 'Common Work Schedule';

  @override
  String get taskScheduleRegister => 'Work Schedule Registration';

  @override
  String get taskTimeKeepingTitle => 'Timekeeping';

  @override
  String get taskAddAndEditAdtendance => 'Add/Edit Timekeeping';

  @override
  String get taskTimeKeepingEquipment => 'Timekeeping Equipment';

  @override
  String get taskSalaryTitle => 'Salary';

  @override
  String get taskSalaryAdvanceSlip => 'Salary Advance Slip';

  @override
  String get taskSalaryIsOnHold => 'Salary in Hold';

  @override
  String get taskAutomaticSalary => 'Automatic Salary Increase Process';

  @override
  String get taskSalaryHistory => 'Automatic Salary Increase History';

  @override
  String get taskSalarySlip => 'Salary Slip';

  @override
  String get notificationTitle => 'Notification';

  @override
  String get accountTitle => 'Account';

  @override
  String get companyInformation => 'Information company';

  @override
  String get language => 'Language';

  @override
  String get logout => 'Logout';

  @override
  String get guest => 'guest';

  @override
  String get pleaseSignIn => 'please sign in';

  @override
  String get confirmLogoutTitle => 'confirm logout';

  @override
  String get confirmLogoutMessage => 'confirm you want to logout?';

  @override
  String get cancel => 'cancel';

  @override
  String get confirm => 'confirm';

  @override
  String get logoutSuccess => 'logout successful';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get invalidCredentials => 'Invalid username or password.';

  @override
  String get serverError => 'Server error occurred. Please try again later.';

  @override
  String get unknownError => 'An unknown error has occurred.';

  @override
  String get authSessionExpired => 'Authentication session has expired.';

  @override
  String get invalidInput => 'Invalid input provided.';

  @override
  String notificationsAvailable(Object count) {
    return 'You have $count notifications available.';
  }

  @override
  String get noNotifications => 'No notifications available.';
}
