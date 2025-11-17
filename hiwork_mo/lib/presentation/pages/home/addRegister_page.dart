import 'package:flutter/material.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class RegisterLeavePage extends StatefulWidget {
  const RegisterLeavePage({super.key});

  @override
  State<RegisterLeavePage> createState() => _RegisterLeavePageState();
}

class _RegisterLeavePageState extends State<RegisterLeavePage> {
  DateTime selectedDate = DateTime.now();
  String? selectedShift;
  final reasonController = TextEditingController();

  final List<String> shifts = ['Ca sáng', 'Ca chiều', 'Ca tối'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final dateText = DateFormat('dd/MM/yyyy').format(selectedDate);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          loc.registerLeaveTitle, 
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Ngày nghỉ
            TextField(
              readOnly: true,
              controller: TextEditingController(text: dateText),
              decoration: InputDecoration(
                labelText: loc.leaveDate, 
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey),
                  onPressed: () => _selectDate(context),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Chọn ca nghỉ
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: loc.selectShift, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: selectedShift,
              items: shifts
                  .map((shift) =>
                      DropdownMenuItem(value: shift, child: Text(shift)))
                  .toList(),
              onChanged: (value) => setState(() => selectedShift = value),
            ),
            const SizedBox(height: 16),

            // Lý do xin nghỉ
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: loc.reasonLeave, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Spacer(),

            // Nút gửi
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: gửi dữ liệu
                },
                child: Text(
                  loc.submitLeaveRequest, // 👉 Lấy từ l10n
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
