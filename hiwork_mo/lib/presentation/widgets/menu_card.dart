import 'package:flutter/material.dart';
import 'package:hiwork_mo/core/constants/app_font_size.dart';

class MenuCard extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? content;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icon,
    this.title,
    this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    icon!,
                    width: 28,
                    height: 28,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 8),
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSize.content_12,
                          color: const Color.fromARGB(221, 49, 1, 1),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (content != null)
                Text(
                  content!,
                  style: TextStyle(
                    fontSize: AppFontSize.content_10,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
