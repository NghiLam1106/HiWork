import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/domain/entities/shifts_entity.dart';
import 'package:hiwork_mo/main.dart';
import 'package:hiwork_mo/presentation/bloc/attendanceScan/attendance_scan_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/attendanceScan/attendance_scan_event.dart';
import 'package:hiwork_mo/presentation/bloc/attendanceScan/attendance_scan_state.dart';

class ScanFacePage extends StatefulWidget {
  final bool isCheckout;
  final int idEmployee;

  // ✅ chỉ dùng cho CHECK-OUT (lấy từ Home truyền qua)
  final int? currentAttendanceId;
  final String? currentShiftText;
  final DateTime? currentCheckInTime;

  const ScanFacePage({
    super.key,
    this.isCheckout = false,
    required this.idEmployee,
    this.currentAttendanceId,
    this.currentShiftText,
    this.currentCheckInTime,
  });

  @override
  State<ScanFacePage> createState() => _ScanFacePageState();
}

class _ScanFacePageState extends State<ScanFacePage> {
  CameraController? _controller;
  Future<void>? _initializeCamera;
  bool _isCameraOpened = false;

  @override
  void initState() {
    super.initState();
    _openCamera();

    // ✅ chỉ load shifts khi CHECK-IN
    if (!widget.isCheckout) {
      context.read<AttendanceScanBloc>().add(
        AttendanceLoadShifts(
          idEmployee: widget.idEmployee,
          date: DateTime.now(),
        ),
      );
    }
  }

  void _openCamera() {
    final frontCamera = globalCameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeCamera = _controller!.initialize();
    setState(() => _isCameraOpened = true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _submit(AttendanceScanState state) async {
    // =========================
    // ✅ CHECK-OUT (không cần dropdown)
    // =========================
    if (widget.isCheckout) {
      final idAttendance = widget.currentAttendanceId;
      if (idAttendance == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Không tìm thấy ca đang check-in để check-out"),
          ),
        );
        return;
      }

      context.read<AttendanceScanBloc>().add(
        AttendanceCheckOutSubmit(
          attendanceId: idAttendance, // ✅ dùng id_employeeShift
        ),
      );
      return;
    }

    // =========================
    // ✅ CHECK-IN (cần chọn ca + chụp ảnh)
    // =========================
    final selected = state.selectedShift;
    if (selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chọn ca làm việc")),
      );
      return;
    }

    // camera ready?
    if (_controller == null || !_controller!.value.isInitialized) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Camera chưa sẵn sàng")));
      return;
    }

    try {
      await _initializeCamera;
      final XFile file = await _controller!.takePicture();
      final String imagePath = file.path;

      context.read<AttendanceScanBloc>().add(
        AttendanceCheckInSubmit(
          idEmployee: widget.idEmployee,
          idShiftAssignments: selected.idShiftAssignments,
          imagePath: imagePath,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Chụp ảnh thất bại: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EAF0),
      body: SafeArea(
        child: Column(
          children: [_buildCameraArea(context), _buildBottomPanel(context)],
        ),
      ),
    );
  }

  Widget _buildCameraArea(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 340,
          width: double.infinity,
          color: const Color(0xFFE7EAF0),
          child:
              _isCameraOpened
                  ? FutureBuilder(
                    future: _initializeCamera,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: double.infinity,
                          height: 340,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _controller!.value.previewSize!.height,
                              height: _controller!.value.previewSize!.width,
                              child: CameraPreview(_controller!),
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                  : const SizedBox(),
        ),
        Positioned(
          top: 12,
          right: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 20),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 1.2,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Text(
            widget.isCheckout
                ? "Xác nhận khuôn mặt để check-out"
                : "Đưa khuôn mặt của bạn vào khung hình và\nbấm “Đồng ý”",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BlocConsumer<AttendanceScanBloc, AttendanceScanState>(
          listener: (context, state) {
            if (state.error != null && state.error!.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error!)));
              context.read<AttendanceScanBloc>().add(
                const AttendanceClearError(),
              );
            }

            // ✅ submit OK => pop về Home
            if (state.lastLog != null && !state.submitting) {
              final shiftText =
                  widget.isCheckout
                      ? (widget.currentShiftText ?? "ca")
                      : (() {
                        final s = state.selectedShift?.shift;
                        return (s == null)
                            ? "Ca #${state.selectedShift?.idShift}"
                            : "${s.name} (${s.startTime} - ${s.endTime})";
                      })();

              // ✅ check-in: lấy attendanceId từ lastLog
              // ✅ check-out: dùng attendanceId đang có
              final attendanceId =
                  widget.isCheckout
                      ? widget.currentAttendanceId
                      : state
                          .lastLog!
                          .id; // <--- nhớ: model AttendanceScanModel phải có field id

              Navigator.pop(context, {
                "log": state.lastLog,
                "shiftText": shiftText,
                "attendanceId": attendanceId,
              });
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isCheckout
                      ? "Check-out ca làm việc"
                      : "Check-in ca làm việc",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),

                // ✅ CHECK-OUT: hiển thị ca đang check-in
                if (widget.isCheckout) ...[
                  Text(
                    "Ca đang check-in:",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 1),
                      color: Colors.green.withOpacity(0.06),
                    ),
                    child: Text(
                      widget.currentShiftText ?? "Không có thông tin ca",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ] else ...[
                  // ✅ CHECK-IN: dropdown chọn ca
                  if (state.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.shifts.isEmpty)
                    const Text(
                      "Hôm nay bạn chưa được phân ca.",
                      style: TextStyle(color: Colors.red),
                    )
                  else
                    _buildShiftDropdown(state),
                ],

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed:
                        (state.submitting || state.loading)
                            ? null
                            : () => _submit(state),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.isCheckout
                              ? Colors.green
                              : const Color(0xFF1662B3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child:
                        state.submitting
                            ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : Text(
                              "Đồng ý",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildShiftDropdown(AttendanceScanState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blue, width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: state.selectedShift?.idShiftAssignments,
          items:
              state.shifts.map((a) {
                final s = a.shift;
                final label =
                    (s == null)
                        ? "Ca #${a.idShift}"
                        : "${s.name} [${s.startTime} - ${s.endTime}]";
                return DropdownMenuItem<int>(
                  value: a.idShiftAssignments,
                  child: Text(
                    label,
                    style: const TextStyle(color: Colors.blue),
                  ),
                );
              }).toList(),
          onChanged: (id) {
            if (id == null) return;
            final picked = state.shifts.firstWhere(
              (x) => x.idShiftAssignments == id,
            );
            context.read<AttendanceScanBloc>().add(
              AttendanceSelectShift(picked),
            );
          },
        ),
      ),
    );
  }
}
