import 'package:flutter/material.dart';

class RoleBadge extends StatelessWidget {
  final String userRole;
  final bool isTextBadge;

  const RoleBadge({
    super.key,
    required this.userRole,
    this.isTextBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    Color roleColor;
    IconData roleIcon;
    String roleText;

    switch (userRole) {
      case "moderator":
        roleColor = Colors.blue;
        roleIcon = Icons.shield;
        roleText = "Moderator";
        break;
      case "admin":
        roleColor = Colors.purple;
        roleIcon = Icons.admin_panel_settings;
        roleText = "Admin";
        break;
      case "superadmin":
        roleColor = Colors.amber.shade700;
        roleIcon = Icons.workspace_premium;
        roleText = "Super Admin";
        break;
      default:
        roleColor = const Color.fromARGB(255, 97, 97, 97);
        roleIcon = Icons.person;
        roleText = "User";
    }

    return isTextBadge
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: roleColor.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: roleColor.withAlpha(30), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(roleIcon, color: roleColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  roleText,
                  style: TextStyle(
                    color: roleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        : Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: roleColor, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: roleColor.withAlpha(30),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/1?v=4",
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: roleColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Icon(roleIcon, color: Colors.white, size: 16),
                ),
              ),
            ],
          );
  }
}
