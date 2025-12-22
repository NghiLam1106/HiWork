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

  // Bạn truyền idEmployee từ màn trước (từ Auth/localStorage/profile)
  final int idEmployee;

  // Khi check-in cần ảnh => bạn có thể truyền imagePath sau khi chụp
  // Ở đây mình để sẵn nullable để bạn tích hợp chụp ảnh sau.
  final String? imagePath;

  const ScanFacePage({
    super.key,
    this.isCheckout = false,
    required this.idEmployee,
    this.imagePath,
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

    // ✅ load ca đã phân trong ngày (hoặc bạn truyền date vào event nếu có)
    context.read<AttendanceScanBloc>().add(
      AttendanceLoadShifts(idEmployee: widget.idEmployee, date: DateTime.now()),
    );
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

  void _submit(ShiftAssignmentEntity? selected) {
    if (selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chọn ca làm việc")),
      );
      return;
    }

    if (widget.isCheckout) {
      // ✅ Check-out (bạn đang gọi theo idShift)
      context.read<AttendanceScanBloc>().add(
        AttendanceCheckOutSubmit(
          idEmployee: widget.idEmployee,
          // nếu event bạn chưa có idShift thì thêm vào event
          idShift: selected.idShift,
        ),
      );
    } else {
      // ✅ Check-in cần ảnh
      final path = widget.imagePath;
      if (path == null || path.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Chưa có ảnh khuôn mặt để check-in")),
        );
        return;
      }

      context.read<AttendanceScanBloc>().add(
        AttendanceCheckInSubmit(
          idEmployee: widget.idEmployee,
          imagePath: path,
          // nếu event bạn chưa có idShift thì thêm vào event
          idShift: selected.idShift,
        ),
      );
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
        const Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Text(
            "Đưa khuôn mặt của bạn vào khung hình và\nbấm “Đồng ý”",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
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

            // nếu submit thành công (có lastLog) thì pop về
            if (state.lastLog != null && !state.submitting) {
              Navigator.pop(context, state.lastLog);
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

                if (state.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.shifts.isEmpty)
                  const Text(
                    "Hôm nay bạn chưa được phân ca.",
                    style: TextStyle(color: Colors.red),
                  )
                else
                  _buildShiftDropdown(state),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed:
                        (state.submitting || state.loading)
                            ? null
                            : () => _submit(state.selectedShift),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1662B3),
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
                            : const Text(
                              "Đồng ý",
                              style: TextStyle(
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
                final s = a.shift; // ✅ shift đã parse
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
