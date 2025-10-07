import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/shared_prefs/auth_local_storage.dart';

class HelperFunctions {
  static Future<int?> getUid() async {
    return await AuthLocalStorage.getUid();
  }

  static String getRoleLabel(String role) {
    switch (role.toUpperCase()) {
      case "MODERATOR":
        return "Access Moderator Privileges";
      case "ADMIN":
        return "Access Admin Privileges";
      case "SUPER_ADMIN":
        return "Access Super Admin Privileges";
      default:
        return "Become a Moderator";
    }
  }

  static Color getRoleColor(String role) {
    switch (role.toUpperCase()) {
      case "MODERATOR":
        return Colors.blue;
      case "ADMIN":
        return Colors.purple;

      case "SUPER_ADMIN":
        return Colors.amber.shade700;
      default:
        return Colors.grey.shade800;
    }
  }
}
