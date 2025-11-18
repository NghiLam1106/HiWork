import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/domain/entities/leave_request_entity.dart';
import 'package:hiwork_mo/presentation/bloc/leave/leave_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/leave/leave_event.dart';
import 'package:hiwork_mo/presentation/bloc/leave/leave_state.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart'; // Import AppRoute

// 1. Chuyển thành StatefulWidget
class LeaveHistoryRegisterPage extends StatefulWidget {
  const LeaveHistoryRegisterPage({super.key});

  @override
  State<LeaveHistoryRegisterPage> createState() => _LeaveHistoryRegisterPageState();
}

class _LeaveHistoryRegisterPageState extends State<LeaveHistoryRegisterPage> {
  @override
  void initState() {
    super.initState();
    // 2. Gửi sự kiện yêu cầu tải dữ liệu (Lịch sử + Số dư) khi trang mở
    // (Vì BLoC này đã được cung cấp (Provided) trong main.dart, nên gọi ở đây là được)
    context.read<LeaveBloc>().add(LoadLeaveData());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE6ECF4), // nền xanh xám nhạt
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A73E8)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.leaveRegisterTitle, // "Đăng ký nghỉ"
          style: const TextStyle(
            color: Color(0xFF1A73E8),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      // 3. Sử dụng BlocBuilder để hiển thị nội dung động
      body: Column(
        children: [
          // (Phần Header chọn tháng giữ nguyên)
          Container(height: 0.5, color: Colors.black26),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E5EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                l10n.leaveRegisterMonth('11', '2025'), // "Tháng 11 2025"
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),

          // 4. Nội dung chính (Thay thế Placeholder bằng BlocBuilder)
          Expanded(
            child: BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                // A. Trạng thái Đang Tải
                if (state is LeaveLoading || state is LeaveInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                // B. Trạng thái Lỗi
                if (state is LeaveError) {
                  return Center(child: Text(state.message));
                }

                // C. Trạng thái Tải Xong
                if (state is LeaveLoaded) {
                  // C1. Nếu danh sách Lịch sử trống
                  if (state.history.isEmpty) {
                    return _buildEmptyPlaceholder(l10n); // Hiển thị Placeholder gốc
                  }
                  
                  // C2. Nếu có dữ liệu
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      return _LeaveHistoryCard(request: state.history[index]);
                    },
                  );
                }

                return _buildEmptyPlaceholder(l10n); // Mặc định
              },
            ),
          ),
        ],
      ),

      // 5. Sửa FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 6. SỬA ĐIỀU HƯỚNG: Dùng Named Route
          // (Đảm bảo AppRoute.leaveRequest đã được định nghĩa và trỏ đến LeaveRequestPage)
          Navigator.pushNamed(context, AppRoute.leaveRequest);
        },
        backgroundColor: const Color(0xFF1A73E8),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Widget Placeholder gốc (nếu không có dữ liệu)
  Widget _buildEmptyPlaceholder(AppLocalizations l10n) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.format_quote,
              size: 36,
              color: Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              l10n.leaveRegisterHint, // "Chưa có yêu cầu nghỉ phép..."
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}


// --- WIDGET MỚI: Card Lịch sử (Dùng để render ListView) ---
class _LeaveHistoryCard extends StatelessWidget {
  final LeaveRequestEntity request;
  const _LeaveHistoryCard({required this.request});

  Color _getStatusColor(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.approved:
        return Colors.green;
      case LeaveStatus.rejected:
        return Colors.red;
      case LeaveStatus.pending:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(LeaveStatus status, AppLocalizations l10n) {
     switch (status) {
      case LeaveStatus.approved:
        return l10n.statusApproved; // "Đã duyệt"
      case LeaveStatus.rejected:
        return l10n.statusRejected; // "Từ chối"
      case LeaveStatus.pending:
        return l10n.statusPending; // "Chờ duyệt"
      default:
        return l10n.statusUnknown; // "Không rõ"
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = _getStatusColor(request.status);
    final statusText = _getStatusText(request.status, l10n);
    final formattedDate = "${request.fromDate.day}/${request.fromDate.month}/${request.fromDate.year}";

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.leaveType, // "Nghỉ phép năm"
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Ngày: $formattedDate",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              "Số ngày: ${request.daysRequested}",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              "Lý do: ${request.reason}",
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}