import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/session_keys.dart';
import '../domain/login_response.dart';

class SessionManager {
  Future<void> saveApiSession(LoginResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SessionKeys.token, user.accessToken);
    await prefs.setString(SessionKeys.username, user.username);
    await prefs.setString(SessionKeys.fullName, user.fullName);
    await prefs.setString(SessionKeys.email, user.email);
    await prefs.setString(SessionKeys.loginType, 'api');
  }

  Future<bool> hasApiSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(SessionKeys.token);
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, String>> getApiProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      SessionKeys.username: prefs.getString(SessionKeys.username) ?? '',
      SessionKeys.fullName: prefs.getString(SessionKeys.fullName) ?? '',
      SessionKeys.email: prefs.getString(SessionKeys.email) ?? '',
      SessionKeys.token: prefs.getString(SessionKeys.token) ?? '',
      SessionKeys.loginType: prefs.getString(SessionKeys.loginType) ?? '',
    };
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
