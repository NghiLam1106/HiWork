import 'package:flutter/material.dart';

class LeaveOptionPicker extends StatefulWidget {
  final List<String> initialValues;
  final Function(List<String>) onSelected;

  const LeaveOptionPicker({
    super.key,
    required this.initialValues,
    required this.onSelected,
  });

  @override
  State<LeaveOptionPicker> createState() => _LeaveOptionPickerState();
}

class _LeaveOptionPickerState extends State<LeaveOptionPicker> {
  // Chỉ cho phép chọn tối đa 2 ca
  List<String> selectedValues = [];

  final List<Map<String, String>> options = [
    {"key": "morning", "label": "Ca sáng [7:00 - 12:00]"},
    {"key": "noon", "label": "Ca trưa [12:00 - 17:30]"},
    {"key": "night", "label": "Ca tối [17:30 - 23:30]"},
  ];

  @override
  void initState() {
    super.initState();
    selectedValues = [...widget.initialValues];
  }

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
          ...options.map(_buildOptionItem),
          const SizedBox(height: 16),
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
        "Chọn ca làm",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildOptionItem(Map<String, String> op) {
    final key = op["key"]!;
    final isSelected = selectedValues.contains(key);

    final isDisabled = !isSelected && selectedValues.length >= 2;

    return InkWell(
      onTap: isDisabled
          ? null
          : () {
              setState(() {
                if (isSelected) {
                  selectedValues.remove(key);
                } else {
                  if (selectedValues.length < 2) {
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
                color: isDisabled ? Colors.grey : Colors.blue.shade700,
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
                color: isSelected ? Colors.blue.shade700 : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
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
          backgroundColor:
              selectedValues.isNotEmpty ? Colors.blue.shade700 : Colors.grey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: selectedValues.isNotEmpty
            ? () {
                Navigator.pop(context);
                widget.onSelected(selectedValues);
              }
            : null,
        child: const Text(
          "Xác nhận",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
