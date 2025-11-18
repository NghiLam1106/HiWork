import 'package:flutter/material.dart';

class LeaveOptionPicker extends StatefulWidget {
  // Thay đổi kiểu dữ liệu của onSelected để nhận List<String>
  final Function(List<String>) onSelected;

  const LeaveOptionPicker({super.key, required this.onSelected, required List<String> initialValues});
  

  @override
  State<LeaveOptionPicker> createState() => _LeaveOptionPickerState();
}

class _LeaveOptionPickerState extends State<LeaveOptionPicker> {
  // Thay đổi thành List<String> để lưu nhiều giá trị được chọn
  List<String> selectedValues = [];

  final List<Map<String, String>> options = [
    {"key": "morning", "label": "Ca sáng [7:00 - 12:00]"},
    {"key": "noon", "label": "Ca trưa [12:00 - 17:30]"},
    {"key": "night", "label": "Ca tối [17:30 - 23:30]"},
    {"key": "full", "label": "Cả ngày"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          ...options.map((op) => _buildOptionItem(op)),
          const SizedBox(height: 16),
          // Thêm nút xác nhận (hoặc bạn có thể giữ nguyên hành vi pop sau khi chọn)
          _buildConfirmButton(context), 
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      alignment: Alignment.centerLeft,
      child: const Text(
        "Chọn ca nghỉ",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildOptionItem(Map<String, String> op) {
    final key = op["key"]!;
    // Kiểm tra xem tùy chọn này có đang được chọn hay không
    final isSelected = selectedValues.contains(key);
    // Tùy chọn "Cả ngày"
    final isFullDayOption = key == "full";
    // Số lượng tùy chọn không phải "Cả ngày" đã được chọn
    final nonFullDayCount = selectedValues.where((k) => k != "full").length;
    // Tùy chọn có bị vô hiệu hóa để chọn thêm không
    final isDisabled = !isSelected && !isFullDayOption && selectedValues.contains("full") || 
                       !isSelected && !isFullDayOption && nonFullDayCount >= 2;


    return InkWell(
      onTap: isDisabled ? null : () {
        setState(() {
          if (isFullDayOption) {
            // Logic cho "Cả ngày": Nếu chọn "Cả ngày", bỏ chọn tất cả và chỉ chọn "Cả ngày"
            if (isSelected) {
              selectedValues.clear(); // Bỏ chọn
            } else {
              selectedValues.clear();
              selectedValues.add(key); // Chỉ chọn "Cả ngày"
            }
          } else {
            // Logic cho các ca: Nếu "Cả ngày" đã được chọn, không cho phép chọn ca khác
            if (selectedValues.contains("full")) {
              // Đã có logic chặn ở `isDisabled`, nhưng phòng ngừa
              return; 
            }
            
            if (isSelected) {
              // Bỏ chọn
              selectedValues.remove(key);
            } else if (selectedValues.length < 2) {
              // Chọn thêm nếu chưa đủ 2
              selectedValues.add(key);
            }
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              op["label"]!,
              style: TextStyle(
                fontSize: 15,
                color: isDisabled ? Colors.grey : Colors.blue.shade700, // Thay đổi màu khi bị vô hiệu hóa
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDisabled ? Colors.grey : Colors.blue.shade700,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
                color: isSelected && !isDisabled ? Colors.blue.shade700 : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, left: 20.0, right: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: selectedValues.isNotEmpty ? Colors.blue.shade700 : Colors.grey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: selectedValues.isNotEmpty ? () {
          Navigator.pop(context);
          // Truyền danh sách các giá trị đã chọn
          widget.onSelected(selectedValues);
        } : null,
        child: const Text(
          "Xác nhận",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// --- Hướng dẫn cách sử dụng ---
// Để hiển thị lại các tùy chọn đã chọn ở trang đăng ký, bạn có thể 
// tạo một hàm sử dụng `showModalBottomSheet` và cập nhật state của trang chính.

/*
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  List<String> selectedLeaveOptions = [];

  // Hàm chuyển đổi key thành label để hiển thị
  String _getLeaveLabels(List<String> keys) {
    if (keys.isEmpty) return "Chưa chọn ca nghỉ";
    if (keys.contains("full")) return "Cả ngày";
    
    final labels = keys.map((key) {
      if (key == "morning") return "Ca sáng";
      if (key == "noon") return "Ca trưa";
      if (key == "night") return "Ca tối";
      return "";
    }).join(", ");
    
    return labels;
  }

  void _showLeaveOptionPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return LeaveOptionPicker(
          onSelected: (List<String> options) {
            setState(() {
              selectedLeaveOptions = options;
            });
            // Hiển thị kết quả đã chọn (ví dụ)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đã chọn: ${_getLeaveLabels(options)}')),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng Ký Nghỉ Phép")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ca nghỉ đã chọn:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              _getLeaveLabels(selectedLeaveOptions),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showLeaveOptionPicker,
              child: const Text("Chọn Ca Nghỉ"),
            ),
          ],
        ),
      ),
    );
  }
}
*/