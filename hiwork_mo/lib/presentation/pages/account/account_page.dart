import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_assets.dart';
import 'package:hiwork_mo/core/constants/app_colors.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';
import 'package:hiwork_mo/core/constants/app_padding.dart';
import 'package:hiwork_mo/l10n/app_localizations.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      
      body: Column(
        children: [
          _buildProfileHeader(context),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  imagePath: AppAssets.companyInfo,
                  text: l10n.companyInformation, // "Thông tin công ty"
                  onTap: () {},
                ),
                _buildMenuItem(
                  imagePath: AppAssets.language,
                  text: l10n.language, // "Ngôn ngữ"
                  onTap: () {},
                ),
                const Divider(),
                _buildLogoutButton(
                  imagePath: AppAssets.logout,
                  label: l10n.logout, // "Đăng xuất"
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Vo Huong",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.title_20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Chỉnh sửa thông tin cá nhân",
                    style: TextStyle(
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
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildLogoutButton({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 26,
        height: 26,
        color: Colors.red,
      ),
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
