import 'package:shared_preferences/shared_preferences.dart';

class Username {
  static String username = '';

  static Future<void> loadusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? '';
  }

  static Future<void> saveusername(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', id);
    username = id;
  }

  static Future<String?> getusername() async {
    if (username.isEmpty) {
      await loadusername();
    }
    return username.isNotEmpty ? username : null;
  }

  static Future<void> clearusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    username = '';
  }

  
}