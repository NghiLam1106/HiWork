import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/core/injection/dependency_injection.dart';
import 'package:hiwork_mo/data/local/employee_storage.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';
import 'package:hiwork_mo/presentation/bloc/employee_detail/employee_detail_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/employee_detail/employee_detail_event.dart';
import 'package:hiwork_mo/presentation/bloc/employee_detail/employee_detail_state.dart';
import 'package:hiwork_mo/presentation/bloc/employee_personal_edit/employee_personal_edit_bloc.dart';

import 'employee_personal_edit_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (!mounted) return;

    context.read<EmployeeDetailBloc>().add(EmployeeDetailRequested());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onEditPersonal(
    EmployeeDetailLoaded state,
    String? authEmail,
  ) async {
    final emp = state.employee;

    final int genderValue =
        (emp.gender == null)
            ? 2
            : (emp.gender == "Nam" || emp.gender == "male")
            ? 1
            : (emp.gender == "Nữ" || emp.gender == "female")
            ? 0
            : 2;

    final emailFromAuth = (authEmail ?? "").trim();
    final email = emailFromAuth;

    final changed = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (_) => sl<EmployeePersonalEditBloc>(),
              child: EmployeePersonalEditPage(
                employeeId: emp.id,
                initialName: emp.name ?? "",
                initialEmail: email, // ✅ lấy từ AuthBloc ưu tiên
                initialGender: genderValue,
                initialAddress: emp.address ?? "",
                initialImageUrl: emp.avatarUrl,
                initialPhone: emp.phone ?? "",
              ),
            ),
      ),
    );

    if (changed == true && context.mounted) {
      context.read<EmployeeDetailBloc>().add(const EmployeeDetailRefreshed());
    }
  }

  String _formatDob(dynamic dob) {
    // dob có thể là DateTime hoặc String tuỳ entity/model của bạn
    if (dob == null) return "";
    if (dob is DateTime) {
      String two(int n) => n.toString().padLeft(2, "0");
      return "${two(dob.day)}/${two(dob.month)}/${dob.year}";
    }
    // nếu lỡ BE trả string ISO, bạn parse thử:
    if (dob is String && dob.trim().isNotEmpty) {
      final parsed = DateTime.tryParse(dob);
      if (parsed == null) return dob; // giữ nguyên nếu parse fail
      String two(int n) => n.toString().padLeft(2, "0");
      return "${two(parsed.day)}/${two(parsed.month)}/${parsed.year}";
    }
    return "";
  }

  Map<String, String> _buildPersonalInfo(
    EmployeeDetailLoaded state,
    String? authEmail,
  ) {
    final emp = state.employee;

    final emailFromAuth = (authEmail ?? "").trim();
    final email = emailFromAuth;

    return {
      "Họ tên": emp.name ?? "",
      "Email": email,
      "Giới tính":
          (emp.gender == 1 || emp.gender == "male")
              ? "Nam"
              : (emp.gender == 2 || emp.gender == "female")
              ? "Nữ"
              : "Khác",
      "Địa chỉ": emp.address ?? "",
      "Số điện thoại": emp.phone ?? "",
      "Ngày sinh": _formatDob(emp.dayOfBirth) ?? "",
    };
  }

  Map<String, String> _buildCompanyInfo(EmployeeDetailLoaded state) {
    final emp = state.employee;

    return {
      "Tên công ty": "Công ty ABC",
      "Mô hình kinh doanh": "Kinh doanh cà phê",
      "Địa chỉ": "Đà Nẵng",
    };
  }

  @override
  Widget build(BuildContext context) {
    final authEmail = context.select<AuthBloc, String?>((b) {
      final s = b.state;
      if (s is Authenticated) return s.user.email;
      return null;
    });

    return BlocBuilder<EmployeeDetailBloc, EmployeeDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  context.read<EmployeeDetailBloc>().add(
                    const EmployeeDetailRefreshed(),
                  );
                },
                icon: const Icon(Icons.refresh, color: Colors.black54),
              ),
            ],
          ),
          // ✅ truyền authEmail xuống body
          body: _buildBody(state, authEmail),
        );
      },
    );
  }

  Widget _buildBody(EmployeeDetailState state, String? authEmail) {
    if (state is EmployeeDetailLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is EmployeeDetailError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Không tải được dữ liệu: ${state.message}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<EmployeeDetailBloc>().add(
                    const EmployeeDetailRefreshed(),
                  );
                },
                child: const Text("Thử lại"),
              ),
            ],
          ),
        ),
      );
    }

    if (state is! EmployeeDetailLoaded) {
      return const SizedBox();
    }

    final emp = state.employee;

    final avatarUrl =
        emp.avatarUrl ??
        "https://images.unsplash.com/photo-1520975916090-3105956dac38?w=200";
    final fullName = emp.name ?? "—";

    // ✅ positionId thường là int -> ép về String cho an toàn
    final role = emp.positionId ?? "Nhân viên"; // nếu bạn có field này thì dùng
    // nếu không có positionName thì dùng:
    // final role = (emp.positionId != null) ? "Position #${emp.positionId}" : "Nhân viên";

    // ✅ personalInfo: email ưu tiên lấy từ AuthBloc
    final personalInfo = _buildPersonalInfo(state, authEmail);
    final companyInfo = _buildCompanyInfo(state);

    return Column(
      children: [
        _Header(
          avatarUrl: avatarUrl,
          fullName: fullName,
          role: emp.positionId ?? "Nhân viên",
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF1A73E8),
            unselectedLabelColor: Colors.black87,
            indicatorColor: const Color(0xFF1A73E8),
            indicatorWeight: 2,
            tabs: const [Tab(text: "Cá nhân"), Tab(text: "Công ty")],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Stack(
                children: [
                  _InfoList(
                    items: personalInfo,
                    showImage: true,
                    imageLabel: "Ảnh đăng ký",
                    imageUrl: emp.imageCheck,
                  ),
                  Positioned(
                    right: 18,
                    top: 0,
                    child: InkWell(
                      onTap: () => _onEditPersonal(state, authEmail),
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.transparent,
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.black54,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _InfoList(items: companyInfo),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String avatarUrl;
  final String fullName;
  final String role;

  const _Header({
    required this.avatarUrl,
    required this.fullName,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
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

class _InfoList extends StatelessWidget {
  final Map<String, String> items;
  final String? imageUrl;
  final String? imageLabel;
  final bool showImage;

  const _InfoList({
    required this.items,
    this.imageUrl,
    this.imageLabel,
    this.showImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          ...items.entries.map((e) => _InfoRow(label: e.key, value: e.value)),
          if (showImage) ...[
            const SizedBox(height: 8),
            Text(
              imageLabel ?? "Ảnh đăng ký",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _ImageBox(imageUrl: imageUrl),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isEmpty = value.trim().isEmpty;
    final displayValue = isEmpty ? "Chưa cập nhật" : value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              displayValue,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 13,
                color: isEmpty ? Colors.black45 : Colors.black87,
                fontWeight: FontWeight.w700,
                fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  final String? imageUrl;

  const _ImageBox({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final url = (imageUrl ?? "").trim();

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black26),
        color: Colors.grey.shade100,
      ),
      clipBehavior: Clip.antiAlias,
      child:
          url.isEmpty
              ? const Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: Colors.black26,
                ),
              )
              : Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder:
                    (_, __, ___) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.black26,
                      ),
                    ),
              ),
    );
  }
}
