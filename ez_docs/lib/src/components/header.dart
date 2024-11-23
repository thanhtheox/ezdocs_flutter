import 'package:flutter/material.dart';
import '../assets/constants/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String activeTab;
  final VoidCallback? onHelpTap;
  final Function(String) onTabSelected;

  const CustomAppBar({
    super.key,
    required this.activeTab,
    this.onHelpTap,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mindaro,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Logo",
            style: TextStyle(color: Colors.black),
          ),
          Row(
            children: [
              _buildAppBarButton("Dịch thuật",
                  isActive: activeTab == "Dịch thuật"),
              _buildAppBarButton("Tóm tắt", isActive: activeTab == "Tóm tắt"),
              _buildAppBarButton("ChatBot", isActive: activeTab == "ChatBot"),

              IconButton(
                icon: const Icon(Icons.help_outline, color: Colors.black),
                onPressed: onHelpTap ?? () {},
              ),

              const Text(
                "Trợ giúp",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarButton(String title, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          onTabSelected(title);
        },
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            decoration: isActive ? TextDecoration.underline : null,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
