import 'package:antiquewebemquiry/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController storeCodeController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  
  bool _rememberMe = false;  // Changed default to false
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
      // Save current values when remember me is enabled
      _savedStoreCode = storeCodeController.text.trim();
      _savedUsername = usernameController.text.trim();
      _savedPassword = passwordController.text.trim();
    } else {
      // Clear saved values when remember me is disabled
      _savedStoreCode = null;
      _savedUsername = null;
      _savedPassword = null;
      
      // Clear text fields
      storeCodeController.clear();
      usernameController.clear();
      passwordController.clear();
    }
    
    notifyListeners();
  }

  // Method to restore saved credentials
  void restoreSavedCredentials() {
    if (_rememberMe && _savedStoreCode != null) {
      storeCodeController.text = _savedStoreCode!;
      usernameController.text = _savedUsername!;
      passwordController.text = _savedPassword!;
    }
  }

  Future<bool> login(BuildContext context) async {
    String storeCode = storeCodeController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // Simulating login process
    await Future.delayed(const Duration(seconds: 1));

    if (storeCode == "1234" && username == "admin" && password == "password") {
      // ignore: avoid_print
      print("Login successful!");
      
      // Save credentials if remember me is enabled
      if (_rememberMe) {
        _savedStoreCode = storeCode;
        _savedUsername = username;
        _savedPassword = password;
      }

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      return true;
    } else {
      return false;
    }
  }

  // Method to clear all stored data
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