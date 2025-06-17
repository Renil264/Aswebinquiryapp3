import 'package:shared_preferences/shared_preferences.dart';

class Vendor {
  static String vendorid = '';

  static Future<void> loadvendorid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorid = prefs.getString('vendorid') ?? '';
  }

  static Future<void> savevendorid(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('vendorid', id);
    vendorid = id;
  }

  static Future<String?> getvendorid() async {
    if (vendorid.isEmpty) {
      await loadvendorid();
    }
    return vendorid.isNotEmpty ? vendorid : null;
  }

  static Future<void> clearvendorid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('vendorid');
    vendorid = '';
  }

 
}