import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hiwork_mo/main.dart';

class ScanFacePage extends StatefulWidget {
  final bool isCheckout;

  const ScanFacePage({super.key, this.isCheckout = false});

  @override
  State<ScanFacePage> createState() => _ScanFacePageState();
}

class _ScanFacePageState extends State<ScanFacePage> {
  CameraController? _controller;
  Future<void>? _initializeCamera;
  bool _isCameraOpened = false;

  final List<String> _shifts = const [
    "Ca sáng [7:00 - 12:00]",
    "Ca chiều [12:00 - 17:30]",
    "Ca tối [17:30 - 23:30]",
  ];

  String? _selectedShift;

  @override
  void initState() {
    super.initState();
    _selectedShift = _shifts.first;
    _openCamera();
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

  Future<void> _onConfirm() async {
    // ✅ TODO: sau này chụp ảnh + gọi API check-in
    // Hiện tại chỉ demo:
    if (_selectedShift == null) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Đã chọn: $_selectedShift")));
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

        // CLOSE BUTTON
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

        // FACE FRAME
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

        // INSTRUCTION TEXT
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: const Text(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isCheckout
                  ? "Check-out ca làm việc"
                  : "Check-in ca làm việc",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),

            _buildShiftDropdown(),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedShift == null) return;

                  Navigator.pop(context, _selectedShift);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1662B3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Đồng ý",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blue, width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedShift,
          items:
              _shifts
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(
                        s,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() => _selectedShift = value);
          },
        ),
      ),
    );
  }
}
