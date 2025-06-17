import 'package:shared_preferences/shared_preferences.dart';

class Location {
  static String location = '';

  static Future<void> loadlocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    location = prefs.getString('location') ?? '';
  }

  static Future<void> savelocation(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', id);
    location = id;
  }

  static Future<String?> getlocation() async {
    if (location.isEmpty) {
      await loadlocation();
    }
    return location.isNotEmpty ? location : null;
  }

  static Future<void> clearlocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('location');
    location = '';
  }


}