// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'HiWork';

  @override
  String get languageLabel => 'Ngôn ngữ';

  @override
  String get welcomeMessage => 'Chào mừng đến với HiWork! - Ứng dụng quản lý nguồn nhân lực hiệu quả';

  @override
  String get loginBtn => 'ĐĂNG NHẬP';

  @override
  String get registerBtn => 'ĐĂNG KÝ';

  @override
  String get titleLogin => 'Đăng nhập vào';

  @override
  String get hintTextUsername => 'Tên đăng nhập hoặc Email';

  @override
  String get hintTextPassword => 'Mật khẩu';

  @override
  String get forgotPasword => 'Quên mật khẩu';

  @override
  String get dontHaveAccount => 'Bạn chưa có tài khoản? ';

  @override
  String get registerNow => 'Đăng ký ngay';

  @override
  String get titleRegister => 'Đăng ký tài khoản';

  @override
  String get hintTextFullname => 'Họ và tên';

  @override
  String get hintTextEmail => 'Email';

  @override
  String get hintTextConfirmPassword => 'Xác nhận mật khẩu';

  @override
  String get loginNow => 'Đăng nhập ngay';

  @override
  String get haveAcconunt => 'Bạn đã có tài khoản? ';

  @override
  String get titleScan => 'Quét khuôn mặt';

  @override
  String get titleScanHello => 'Xin chào';

  @override
  String get titleCardJob => 'Lịch làm việc';

  @override
  String get titleCardLeave => 'Đăng ký nghỉ';

  @override
  String get titleCardMoney => 'Kỳ lương';

  @override
  String get titleCardChat => 'Tin nhắn';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navTask => 'Tác vụ';

  @override
  String get navNotification => 'Thông báo';

  @override
  String get navAccount => 'Tài khoản';

  @override
  String get taskTitle => 'Tác vụ';

  @override
  String get workScheduleTitle => 'Lịch làm việc';

  @override
  String get thisWeek => 'Tuần này';

  @override
  String get nextWeek => 'Tuần sau';

  @override
  String get previousWeek => 'Tuần trước';

  @override
  String get shiftMorning => 'Ca sáng';

  @override
  String get shiftNoon => 'Ca trưa';

  @override
  String get shiftEvening => 'Ca tối';

  @override
  String get dayOff => 'Nghỉ';

  @override
  String get onTime => 'Đúng giờ';

  @override
  String get leftEarly => 'Về sớm';

  @override
  String get late => 'Đi muộn';

  @override
  String get today => 'Hôm nay';

  @override
  String get forgotCheckIn => 'Quên chấm công';

  @override
  String get notStartedYet => 'Chưa đến giờ';

  @override
  String get leaveRegisterTitle => 'Danh sách đăng ký nghỉ';

  @override
  String leaveRegisterMonth(Object month, Object year) {
    return 'Tháng $month năm $year';
  }

  @override
  String get leaveRegisterHint => 'Bạn có thể gửi yêu cầu đăng ký nghỉ phép tại đây';

  @override
  String get registerLeaveTitle => 'Đăng ký nghỉ';

  @override
  String get leaveDate => 'Ngày nghỉ';

  @override
  String get selectShift => 'Chọn ca nghỉ';

  @override
  String get reasonLeave => 'Lý do xin nghỉ';

  @override
  String get submitLeaveRequest => 'Gửi đăng ký nghỉ';

  @override
  String get statusApproved => 'Đã duyệt';

  @override
  String get statusRejected => 'Đã từ chối';

  @override
  String get statusPending => 'Chờ duyệt';

  @override
  String get statusUnknown => 'Không xác định';

  @override
  String get taskScheduleCommon => 'Lịch làm việc chung';

  @override
  String get taskScheduleRegister => 'Đăng ký lịch làm việc';

  @override
  String get taskTimeKeepingTitle => 'Chấm công';

  @override
  String get taskAddAndEditAdtendance => 'Bổ sung/ sửa chấm công';

  @override
  String get taskTimeKeepingEquipment => 'Thiết bị chấm công';

  @override
  String get taskSalaryTitle => 'Lương';

  @override
  String get taskSalaryAdvanceSlip => 'Phiếu tạm ứng lương';

  @override
  String get taskSalaryIsOnHold => 'Lương đang giữ';

  @override
  String get taskAutomaticSalary => 'Tiến trình tự động tăng lương';

  @override
  String get taskSalaryHistory => 'Lịch sử tự động tăng lương';

  @override
  String get taskSalarySlip => 'Phiếu lương';

  @override
  String get notificationTitle => 'Thông báo';

  @override
  String get accountTitle => 'Tài khoản';

  @override
  String get companyInformation => 'Thông tin công ty';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get guest => 'Khách';

  @override
  String get pleaseSignIn => 'Vui lòng đăng nhập';

  @override
  String get confirmLogoutTitle => 'Xác nhận đăng xuất';

  @override
  String get confirmLogoutMessage => 'Bạn có chắc chắn muốn đăng xuất không?';

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get logoutSuccess => 'Đăng xuất thành công';

  @override
  String get loginSuccess => 'Đăng nhập thành công';

  @override
  String get invalidCredentials => 'Tên đăng nhập hoặc mật khẩu không hợp lệ.';

  @override
  String get serverError => 'Đã xảy ra lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get unknownError => 'Đã xảy ra lỗi không xác định.';

  @override
  String get authSessionExpired => 'Phiên đăng nhập đã hết hạn.';

  @override
  String get invalidInput => 'Dữ liệu nhập vào không hợp lệ.';

  @override
  String notificationsAvailable(Object count) {
    return 'Bạn có $count thông báo mới.';
  }

  @override
  String get noNotifications => 'Không có thông báo nào.';
}
