// shared_prefs.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }
}
