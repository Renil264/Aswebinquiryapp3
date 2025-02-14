import 'package:antiquewebemquiry/model/change_password_model.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final ChangePasswordModel _model = ChangePasswordModel();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setCurrentPassword(String value) {
    _model.currentPassword = value;
    notifyListeners();
  }

  void setNewPassword(String value) {
    _model.newPassword = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _model.confirmPassword = value;
    notifyListeners();
  }

  Future<bool> updatePassword() async {
    if (!_validateInputs()) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Add your actual API call here
      // await authService.changePassword(_model.currentPassword, _model.newPassword);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update password. Please try again.';
      notifyListeners();
      return false;
    }
  }

  bool _validateInputs() {
    if (_model.currentPassword.isEmpty ||
        _model.newPassword.isEmpty ||
        _model.confirmPassword.isEmpty) {
      _errorMessage = 'All fields are required';
      notifyListeners();
      return false;
    }

    if (_model.newPassword != _model.confirmPassword) {
      _errorMessage = 'New password and confirm password do not match';
      notifyListeners();
      return false;
    }

    if (_model.newPassword.length < 8) {
      _errorMessage = 'New password must be at least 8 characters long';
      notifyListeners();
      return false;
    }

    return true;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}