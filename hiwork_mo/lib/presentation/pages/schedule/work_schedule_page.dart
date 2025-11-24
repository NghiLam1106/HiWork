import 'package:flutter/material.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';

class _ShiftViewModel {
  final String time;
  final String status;

  const _ShiftViewModel({required this.time, required this.status});
}

class _DayScheduleViewModel {
  final String day;
  final bool isOff;
  final String? highlight;
  final List<_ShiftViewModel> shifts;

  const _DayScheduleViewModel({
    required this.day,
    required this.isOff,
    this.highlight,
    required this.shifts,
  });
}

class WorkSchedulePage extends StatefulWidget {
  const WorkSchedulePage({super.key});

  @override
  State<WorkSchedulePage> createState() => _WorkSchedulePageState();
}

class _WorkSchedulePageState extends State<WorkSchedulePage> {
  // [SỬA] Dùng danh sách ViewModels an toàn về kiểu
  List<_DayScheduleViewModel> _schedule = [];
  bool _isLoading = true; // Thêm trạng thái loading

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Chỉ tải dữ liệu một lần
    if (_schedule.isEmpty) {
      _loadDemoData();
    }
  }

  void _loadDemoData() {
    setState(() {
      _isLoading = true;
    });

    final l10n = AppLocalizations.of(context)!;

    final rawDemoData = [
      {"day": "Thứ 2, 03/11/2025", "isOff": true, "shifts": []},
      {
        "day": "Thứ 3, 04/11/2025",
        "isOff": false,
        "shifts": [
          {"time": "${l10n.shiftMorning}[7:00 - 12:00]", "status": l10n.onTime},
          {"time": "${l10n.shiftNoon}[12:00 - 17:30]", "status": l10n.onTime},
        ],
      },
      {
        "day": "Thứ 4, 05/11/2025",
        "isOff": false,
        "shifts": [
          {"time": "${l10n.shiftNoon}[12:00 - 17:30]", "status": l10n.onTime},
          {
            "time": "${l10n.shiftEvening}[17:30 - 23:30]",
            "status": l10n.leftEarly,
          },
        ],
      },

      {
        "day": "Thứ 5, 06/11/2025",
        "isOff": false,
        "shifts": [
          {"time": "${l10n.shiftMorning}[7:00 - 12:00]", "status": l10n.onTime},
          {
            "time": "${l10n.shiftNoon}[12:00 - 17:30]",
            "status": l10n.forgotCheckIn,
          },
        ],
      },

      {
        "day": "Thứ 6, 07/11/2025",
        "isOff": false,
        "highlight": l10n.today,
        "shifts": [
          {
            "time": "${l10n.shiftEvening}[17:30 - 23:30]",
            "status": l10n.onTime,
          },
        ],
      },

      {"day": "Thứ 7, 08/11/2025", "isOff": true, "shifts": []},
      {
        "day": "Chủ nhật, 09/11/2025",
        "isOff": false,
        "shifts": [
          {
            "time": "${l10n.shiftEvening}[17:30 - 23:30]",
            "status": l10n.notStartedYet,
          },
        ],
      },
    ];

    // Ánh xạ dữ liệu thô (Map) sang ViewModels
    _schedule =
        rawDemoData.map((dayMap) {
          final List shiftMaps = dayMap['shifts'] as List;
          return _DayScheduleViewModel(
            day: dayMap['day'] as String,
            isOff: dayMap['isOff'] as bool,
            highlight: dayMap['highlight'] as String?,
            shifts:
                shiftMaps.map((shiftMap) {
                  return _ShiftViewModel(
                    time: shiftMap['time'] as String,
                    status: shiftMap['status'] as String,
                  );
                }).toList(),
          );
        }).toList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1A73E8)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.workScheduleTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A73E8),
          ),
        ),
        centerTitle: false,
      ),

      body: Column(
        children: [
          _buildWeekHeader(l10n), // Widget này không đổi
          Expanded(
            // [SỬA] Thêm xử lý trạng thái loading
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      // [SỬA] Dùng _schedule
                      itemCount: _schedule.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        // [SỬA] Truyền ViewModel vào
                        return _buildDayItem(_schedule[index], l10n);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekHeader(AppLocalizations l10n) {
    final Color primaryBlue = const Color(0xFF1A73E8);

    return Column(
      children: [
        Container(height: 0.5, color: Colors.black26),

        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                },
                icon: Icon(Icons.arrow_back_ios, size: 18, color: primaryBlue),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "3/11/2025 – 09/11/2025", // Data mẫu
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayItem(_DayScheduleViewModel item, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Day Title
          Row(
            children: [
              Expanded(
                child: Text(
                  item.day, // [SỬA] Dùng item.day
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // [SỬA] Dùng item.isOff
              if (item.isOff) _statusBadge(l10n.dayOff, Colors.grey),
              // [SỬA] Dùng item.highlight
              if (item.highlight != null)
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      item.highlight!,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (item.isOff) const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Column(
              children: [
                // [SỬA] Dùng item.shifts
                for (var shift in item.shifts) ...[
                  _buildShiftItem(shift, l10n),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // [SỬA] Dùng _ShiftViewModel thay vì Map
  Widget _buildShiftItem(_ShiftViewModel shift, AppLocalizations l10n) {
    // [SỬA] Dùng shift.time và shift.status
    final String time = shift.time;
    final String status = shift.status;

    Color badgeColor = Colors.grey;
    if (status == l10n.onTime) badgeColor = Colors.green;
    if (status == l10n.leftEarly) badgeColor = Colors.orange;
    if (status == l10n.forgotCheckIn) badgeColor = Colors.red;
    if (status == l10n.notStartedYet) badgeColor = Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1662B3),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _statusBadge(status, badgeColor),
        ],
      ),
    );
  }

  // [KHÔNG ĐỔI] Widget này không phụ thuộc vào data
  Widget _statusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
