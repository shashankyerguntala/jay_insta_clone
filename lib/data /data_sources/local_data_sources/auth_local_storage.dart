import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {////////////////PUT IN LOCAL DATA SOURCE
  static const tokenKey = "auth_token";

  static Future<void> saveUid(int uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('uid', uid);
  }

  static Future<int?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('uid');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}
