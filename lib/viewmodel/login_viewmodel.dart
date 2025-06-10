import 'dart:convert';
import 'package:antiquewebemquiry/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController storeCodeController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  // Stored credentials
  String? _savedStoreCode;
  String? _savedUsername;
  String? _savedPassword;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    if (_rememberMe) {
      _savedStoreCode = storeCodeController.text.trim();
      _savedUsername = usernameController.text.trim();
      _savedPassword = passwordController.text.trim();
    } else {
      _savedStoreCode = null;
      _savedUsername = null;
      _savedPassword = null;
      storeCodeController.clear();
      usernameController.clear();
      passwordController.clear();
    }
    notifyListeners();
  }

  void restoreSavedCredentials() {
    if (_rememberMe && _savedStoreCode != null) {
      storeCodeController.text = _savedStoreCode!;
      usernameController.text = _savedUsername!;
      passwordController.text = _savedPassword!;
    }
  }

  /// 👇 MAIN LOGIN METHOD WITH API INTEGRATION
  Future<bool> login(BuildContext context) async {
    String storeCode = storeCodeController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // Get FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken == null) {
      // Show error dialog or toast
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get FCM token')),
      );
      return false;
    }

    final url = Uri.parse('http://192.168.10.26/Antiquesoft/Home/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "location": storeCode,
      "username": username,
      "password": password,
      "fcmToken": fcmToken,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // You can check status or success field here if your API returns it
        if (_rememberMe) {
          _savedStoreCode = storeCode;
          _savedUsername = username;
          _savedPassword = password;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${response.statusCode}")),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      return false;
    }
  }

  void clearStoredData() {
    _rememberMe = false;
    _savedStoreCode = null;
    _savedUsername = null;
    _savedPassword = null;
    storeCodeController.clear();
    usernameController.clear();
    passwordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    storeCodeController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
