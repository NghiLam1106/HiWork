import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';

class MenuCard extends StatelessWidget {
  final String? icon;
  final String? title;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icon,
    this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(16),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08), // màu bóng nhẹ
                blurRadius: 10, // độ mờ
                offset: const Offset(0, 0), // hướng đổ bóng xuống dưới
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon!, width: 28, height: 28, color: Colors.black54),
              if (title != null) ...[
                const SizedBox(height: 8),
                Text(
                  title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.content_14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
