import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hiwork_mo/presentation/bloc/employee_personal_edit/employee_personal_edit_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/employee_personal_edit/employee_personal_edit_event.dart';
import 'package:hiwork_mo/presentation/bloc/employee_personal_edit/employee_personal_edit_state.dart';

class EmployeePersonalEditPage extends StatefulWidget {
  final int employeeId;

  final String initialName;
  final String initialEmail;
  // final DateTime? initialDob;
  final int initialGender; // 1=Nam, 0=Nữ, 2=Khác
  final String initialAddress;
  final String? initialImageUrl;
  final String initialPhone;

  const EmployeePersonalEditPage({
    super.key,
    required this.employeeId,
    required this.initialName,
    required this.initialEmail,
    // required this.initialDob,
    required this.initialGender,
    required this.initialAddress,
    required this.initialImageUrl,
    required this.initialPhone,
  });

  @override
  State<EmployeePersonalEditPage> createState() =>
      _EmployeePersonalEditPageState();
}

class _EmployeePersonalEditPageState extends State<EmployeePersonalEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _phoneCtrl;

  DateTime? _dob;
  late int _gender;

  String? _pickedImagePath; // ảnh mới chọn (local)

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _addressCtrl = TextEditingController(text: widget.initialAddress);
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
    // _dob = widget.initialDob;
    _gender = widget.initialGender;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _pick(ImageSource src) async {
    final x = await _picker.pickImage(source: src, imageQuality: 80);
    if (x == null) return;
    setState(() => _pickedImagePath = x.path);
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(now.year - 20),
      firstDate: DateTime(1950, 1, 1),
      lastDate: now,
    );
    if (picked != null) setState(() => _dob = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<EmployeePersonalEditBloc>().add(
      EmployeePersonalEditSubmitted(
        id: widget.employeeId,
        name: _nameCtrl.text.trim(),
        address: _addressCtrl.text.trim(),
        gender: _gender,
        dob: _dob,
        pickedImagePath: _pickedImagePath, //ảnh mới (nếu có)
        phone: _phoneCtrl.text.trim(),
      ),
    );
  }

  String _fmt(DateTime? d) {
    if (d == null) return "Chọn ngày sinh";
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return "$dd/$mm/${d.year}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeePersonalEditBloc, EmployeePersonalEditState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pop(context, true);
        }
        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Lỗi: ${state.error}")));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Chỉnh sửa cá nhân",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: _submit,
              child: const Text(
                "Lưu",
                style: TextStyle(
                  color: Color(0xFF1A73E8),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<EmployeePersonalEditBloc, EmployeePersonalEditState>(
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state.isLoading,
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      children: [
                        _label("Ảnh đăng ký"),
                        _RegisterImageBox(
                          networkUrl: widget.initialImageUrl,
                          localPath: _pickedImagePath,
                          onPickGallery: () => _pick(ImageSource.gallery),
                          onPickCamera: () => _pick(ImageSource.camera),
                        ),
                        const SizedBox(height: 18),

                        _label("Họ tên"),
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: _dec("Nhập họ tên"),
                          validator:
                              (v) =>
                                  (v ?? "").trim().isEmpty
                                      ? "Vui lòng nhập họ tên"
                                      : null,
                        ),
                        const SizedBox(height: 14),

                        _label("Email"),
                        TextFormField(
                          initialValue: widget.initialEmail,
                          enabled: false,
                          decoration: _dec("Email"),
                        ),
                        const SizedBox(height: 14),

                        _label("Ngày sinh"),
                        InkWell(
                          onTap: _pickDob,
                          child: InputDecorator(
                            decoration: _dec("Chọn ngày sinh"),
                            child: Text(
                              _fmt(_dob),
                              style: TextStyle(
                                color:
                                    _dob == null
                                        ? Colors.black45
                                        : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        _label("Giới tính"),
                        DropdownButtonFormField<int>(
                          value: _gender,
                          decoration: _dec("Chọn giới tính"),
                          items: const [
                            DropdownMenuItem(value: 1, child: Text("Nam")),
                            DropdownMenuItem(value: 2, child: Text("Nữ")),
                            DropdownMenuItem(value: 3, child: Text("Khác")),
                          ],
                          onChanged: (v) => setState(() => _gender = v ?? 1),
                        ),
                        const SizedBox(height: 14),

                        _label("Số điện thoại"),
                        TextFormField(
                          controller: _phoneCtrl,
                          decoration: _dec("Nhập số điện thoại"),
                          validator:
                              (v) =>
                                  (v ?? "").trim().isEmpty
                                      ? "Vui lòng nhập số điện thoại"
                                      : null,
                        ),
                        const SizedBox(height: 22),

                        _label("Địa chỉ"),
                        TextFormField(
                          controller: _addressCtrl,
                          decoration: _dec("Nhập địa chỉ"),
                          validator:
                              (v) =>
                                  (v ?? "").trim().isEmpty
                                      ? "Vui lòng nhập địa chỉ"
                                      : null,
                        ),
                        const SizedBox(height: 22),

                        SizedBox(
                          height: 46,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A73E8),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Lưu thay đổi",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (state.isLoading)
                    Container(
                      color: Colors.black.withOpacity(0.05),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      t,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black54,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  InputDecoration _dec(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.black45),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 1.2),
    ),
  );
}

class _RegisterImageBox extends StatelessWidget {
  final String? networkUrl;
  final String? localPath;
  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;

  const _RegisterImageBox({
    this.networkUrl,
    this.localPath,
    required this.onPickGallery,
    required this.onPickCamera,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (localPath != null && localPath!.isNotEmpty) {
      child = Image.file(File(localPath!), fit: BoxFit.contain);
    } else if (networkUrl != null && networkUrl!.isNotEmpty) {
      child = Image.network(networkUrl!, fit: BoxFit.contain);
    } else {
      child = const Center(
        child: Icon(Icons.image_outlined, size: 40, color: Colors.black26),
      );
    }

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
        color: Colors.grey.shade100,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            right: 10,
            bottom: 10,
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: onPickGallery,
                  icon: const Icon(
                    Icons.photo_library_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Thư viện",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8),
                    elevation: 0,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: onPickCamera,
                  icon: const Icon(
                    Icons.photo_camera_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
