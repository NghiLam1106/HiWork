import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/widgets/custom_calendar_dialog.dart';
import 'package:hiwork_mo/presentation/widgets/leave_option_picker.dart';
import 'package:hiwork_mo/domain/entities/leave_balance_entity.dart';
import 'package:hiwork_mo/presentation/bloc/leave/leave_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/leave/leave_event.dart';
import 'package:hiwork_mo/presentation/bloc/leave/leave_state.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart'; 

class LeaveRequestPage extends StatefulWidget {
  const LeaveRequestPage({super.key});

  @override
  State<LeaveRequestPage> createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final TextEditingController reasonController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  List<String> fromShift = [];
  List<String> toShift = [];

  // (Loại nghỉ phép - BLoC cần trường này, nhưng UI của bạn không có)
  // (Chúng ta sẽ tạm thời hardcode hoặc bạn có thể thêm 1 Dropdown)
  String _selectedLeaveType = "Nghỉ phép năm"; // <-- TẠM THỜI HARDCODE

  final Color primaryBlue = const Color(0xFF1A73E8);

  @override
  void initState() {
    super.initState();
    // 2. Tải dữ liệu Số dư phép khi trang mở
    // (LeaveBloc đã được cung cấp (Provided) trong main.dart)
    context.read<LeaveBloc>().add(LoadLeaveData());
  }

  // 3. Hàm xử lý logic khi nhấn nút Gửi
  void _onSubmitRequest() {
    // Lấy dữ liệu từ form
    final reason = reasonController.text;
    final leaveType = _getLeaveLabels(fromShift); // Lấy "Cả ngày" hoặc "Ca sáng, Ca trưa"
    
    // (Kiểm tra dữ liệu)
    if (fromDate == null || toDate == null || leaveType == "Chọn ca nghỉ" || reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng điền đầy đủ thông tin."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 4. Gửi Event đến BLoC
    context.read<LeaveBloc>().add(
          SubmitLeaveRequest(
            fromDate: fromDate!,
            toDate: toDate!,
            leaveType: leaveType, // Sử dụng leaveType từ hàm _getLeaveLabels
            reason: reason,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Đăng ký nghỉ",
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      // 5. Thêm BlocListener để xử lý (Loading, Success, Error)
      body: BlocListener<LeaveBloc, LeaveState>(
        listener: (context, state) {
          // A. Nếu Gửi Thành Công
          if (state is LeaveSubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Gửi yêu cầu thành công!"),
                backgroundColor: Colors.green,
              ),
            );
            // Tự động quay về trang Lịch sử
            Navigator.of(context).pop(); 
          }
          // B. Nếu Gửi Thất Bại
          if (state is LeaveError) {
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message), // Hiển thị lỗi từ BLoC
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        child: Column(
          children: [
            Container(height: 0.5, color: Colors.black26),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    
                    // 6. Hiển thị Số Dư Phép (Lấy từ BLoC)
                    _buildLeaveBalance(),

                    // ------------------ FROM DATE ------------------
                    _buildDatePicker(
                      label: "Ngày nghỉ",
                      date: fromDate,
                      onTap: () => _pickDate(true),
                    ),
                    const SizedBox(height: 16),

                    _buildShiftSelector(
                      label: "Ca nghỉ",
                      values: fromShift,
                      onTap: () => _openLeaveOptionPicker(true),
                    ),
                    const SizedBox(height: 24),

                    // ------------------ TO DATE ------------------
                    _buildDatePicker(
                      label: "Đến ngày",
                      date: toDate,
                      onTap: () => _pickDate(false),
                    ),
                    const SizedBox(height: 16),

                    _buildShiftSelector(
                      label: "Ca đến",
                      values: toShift,
                      onTap: () => _openLeaveOptionPicker(false),
                    ),
                    const SizedBox(height: 24),

                    _buildReasonField(),
                    const SizedBox(height: 40),

                    // 7. Nút Gửi (Bọc trong BlocBuilder)
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<LeaveBloc, LeaveState>(
                        builder: (context, state) {
                          // Nếu đang gửi -> Hiển thị Vòng xoay
                          if (state is LeaveSubmissionInProgress) {
                            return ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const CircularProgressIndicator(color: Colors.white),
                            );
                          }

                          // Trạng thái bình thường
                          return ElevatedButton(
                            onPressed: _onSubmitRequest, // 8. Gọi hàm xử lý BLoC
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Gửi đăng ký nghỉ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET MỚI: Hiển thị Số Dư Phép ---
  Widget _buildLeaveBalance() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA), // Nền xám nhạt
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<LeaveBloc, LeaveState>(
        // Chỉ rebuild widget này khi LeaveLoaded
        buildWhen: (previous, current) => current is LeaveLoaded || current is LeaveLoading,
        builder: (context, state) {
          if (state is LeaveLoaded) {
            // Giả sử chỉ lấy loại phép đầu tiên (ví dụ: Nghỉ phép năm)
            final balance = state.balances.firstWhere(
              (b) => b.leaveType == 'Nghỉ phép năm',
              orElse: () => const LeaveBalanceEntity(leaveType: 'N/A', daysRemaining: 0, daysUsed: 0),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Số dư phép năm",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  "${balance.daysRemaining} ngày",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ],
            );
          }
          
          // Hiển thị Loading (hoặc Trạng thái khởi tạo)
          return const Text("Đang tải số dư phép...", style: TextStyle(color: Colors.black54));
        },
      ),
    );
  }


  // (Các hàm UI Components: _buildDatePicker, _buildShiftSelector, v.v... giữ nguyên)
  // ... (Toàn bộ code UI gốc của bạn nằm ở đây)
  // ---------------- UI COMPONENTS -------------------

  Widget _buildDatePicker({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryBlue, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  date != null ? _formatDate(date) : "Chọn ngày",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(Icons.calendar_today, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftSelector({
    required String label,
    required List<String> values, // Thay đổi từ String? sang List<String>
    required VoidCallback onTap,
  }) {
    final String displayText = _getLeaveLabels(values);
    final bool isPlaceholder = values.isEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryBlue, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  displayText, // Sử dụng text đã xử lý
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isPlaceholder ? Colors.black54 : Colors.black87,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryBlue, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: reasonController,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Lý do xin nghỉ",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  void _openLeaveOptionPicker(bool isStart) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (_) => LeaveOptionPicker(
            initialValues: isStart ? fromShift : toShift,
            onSelected: (List<String> values) {
              setState(() {
                if (isStart) {
                  fromShift = values;
                } else {
                  toShift = values;
                }
              });
            },
          ),
    );
  }

  Future<void> _pickDate(bool isStart) async {
    // --- 9. SỬA LỖI Ở ĐÂY ---
    // Code cũ (trong ảnh): builder: const CustomCalendarDialog(),
    // Code mới:
    final result = await showDialog<DateTime>(
      context: context,
      builder: (_) => const CustomCalendarDialog(),
    );
    // --- (Kết thúc sửa lỗi) ---

    if (result != null) {
      setState(() {
        if (isStart) {
          fromDate = result;
        } else {
          toDate = result;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  String _convertShift(String v) {
    switch (v) {
      case "morning":
        return "Ca sáng";
      case "noon":
        return "Ca trưa";
      case "night":
        return "Ca tối";
      case "full":
        return "Cả ngày";
    }
    return "";
  }

  String _getLeaveLabels(List<String> keys) {
    if (keys.isEmpty) return "Chọn ca nghỉ";
    if (keys.contains("full")) return "Cả ngày";

    final labels = keys.map((key) => _convertShift(key)).join(", ");
    return labels;
  }
}