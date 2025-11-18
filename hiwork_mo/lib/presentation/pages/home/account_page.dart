import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_bloc.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_event.dart';
import 'package:hiwork_mo/presentation/bloc/auth/auth_state.dart';
import 'package:hiwork_mo/presentation/route/app_route.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  // Hàm xác nhận Đăng xuất
  void _confirmSignOut(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l10n.confirmLogoutTitle), // "Xác nhận Đăng xuất"
            content: Text(
              l10n.confirmLogoutMessage,
            ), // "Bạn có chắc chắn muốn đăng xuất?"
            actions: [
              TextButton(
                child: Text(l10n.cancel), // "Hủy"
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              TextButton(
                child: Text(
                  l10n.logout, // "Đăng xuất"
                  style: const TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(LogOutRequested());
                  Navigator.of(ctx).pop(); // Đóng dialog
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            // Nếu đã đăng xuất, đẩy về trang Login
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoute.login, (route) => false);
          }
        },
        child: Column(
          children: [
            // 3. Bọc Header bằng BlocBuilder để lấy thông tin User
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                // Đây là trạng thái MẶC ĐỊNH
                String userName = l10n.guest;
                String userEmail = l10n.pleaseSignIn;

                // Nếu ĐÃ XÁC THỰC, gán lại giá trị
                if (state is Authenticated) {
                  userName = state.user.fullName;
                  userEmail = state.user.email;
                }

                return _buildProfileHeader(context, userName, userEmail);
              },
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    imagePath: AppAssets.companyInfo,
                    text: l10n.companyInformation,
                    onTap: () {
                      // Navigator.pushNamed(context, AppRoute.companyInfo);
                    },
                  ),
                  _buildMenuItem(
                    imagePath: AppAssets.language,
                    text: l10n.language,
                    onTap: () {
                      // (Logic đổi ngôn ngữ, gọi LanguageBloc)
                    },
                  ),
                  const Divider(),
                  _buildLogoutButton(
                    imagePath: AppAssets.logout,
                    label: l10n.logout,
                    onTap: () => _confirmSignOut(context), // Gắn hàm logic
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    String userName,
    String userEmail,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/images/avatar.jpg',
            ), // Giữ avatar mẫu
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Điều hướng đến trang Chỉnh sửa hồ sơ
                // Navigator.pushNamed(context, AppRoute.editProfile);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName, // Dùng dữ liệu BLoC
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.title_20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEmail, // Dùng dữ liệu BLoC
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: AppFontSize.content_16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        ],
      ),
    );
  }

  // (Phần _buildMenuItem giữ nguyên)
  Widget _buildMenuItem({
    required String imagePath,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 28,
        height: 28,
        fit: BoxFit.contain,
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: AppFontSize.content_20),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  // (Phần _buildLogoutButton giữ nguyên)
  Widget _buildLogoutButton({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Image.asset(imagePath, width: 26, height: 26, color: Colors.red),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.content_20,
        ),
      ),
      onTap: onTap,
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
