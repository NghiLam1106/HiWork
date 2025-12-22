import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/core/injection/dependency_injection.dart';
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

  // Demo data (sau này bạn bind từ API/BLoC)
  final String avatarUrl =
      "https://images.unsplash.com/photo-1520975916090-3105956dac38?w=200";
  final String fullName = "Vo Huong";
  final String role = "Nhân viên";

  // Ảnh đăng ký (demo)
  final String registerImageUrl =
      "https://images.unsplash.com/photo-1520975916090-3105956dac38?w=200";

  final Map<String, String> personalInfo = const {
    "Họ tên": "Võ Thị Hương",
    "Email": "ho@gmail.com",
    "Giới tính": "",
    "Địa chỉ": "",
    "Số điện thoại": "",
    "Ngày sinh": "",
  };

  final Map<String, String> companyInfo = const {
    "Tên công ty": "TNHH ABC",
    "Mô hình kinh doanh": "System",
    "Địa chỉ": "Đà Nẵng",
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onEditPersonal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (_) => sl<EmployeePersonalEditBloc>(),
              child: EmployeePersonalEditPage(
                employeeId: 1,
                initialName: personalInfo["Họ tên"] ?? "",
                initialEmail: personalInfo["Email"] ?? "",
                initialGender: 2,
                // initialGender:
                //     personalInfo["Giới tính"] == "Nam"
                //         ? 1
                //         : (personalInfo["Giới tính"] == "Nữ" ? 0 : 2),
                // initialAddress: personalInfo["Địa chỉ"] ?? "",
                initialAddress: "",
                // initialImageUrl: registerImageUrl,
                initialImageUrl: null,
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("", style: TextStyle(color: Colors.black87)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _Header(avatarUrl: avatarUrl, fullName: fullName, role: role),
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
                // Cá nhân
                Stack(
                  children: [
                    _InfoList(
                      items: personalInfo,
                      showImage: true,
                      imageLabel: "Ảnh đăng ký",
                      imageUrl: null, // hoặc url thật nếu có
                    ),

                    Positioned(
                      right: 18,
                      top: 0,
                      child: InkWell(
                        onTap: _onEditPersonal,
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

                // Công ty
                _InfoList(items: companyInfo),
              ],
            ),
          ),
        ],
      ),
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
            _ImageBox(imageUrl: imageUrl), // có thể null
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

// ✅ Widget ảnh đăng ký (hiện placeholder nếu null/rỗng)
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
