// login_model.dart

/// Model class for Login Data
class LoginModel {
  final String storeCode;
  final String userName;
  final String password;
  final bool rememberMe;

  LoginModel({
    required this.storeCode,
    required this.userName,
    required this.password,
    this.rememberMe = false,
  });

  /// Convert model data to JSON format
  Map<String, dynamic> toJson() {
    return {
      'storeCode': storeCode,
      'userName': userName,
      'password': password,
      'rememberMe': rememberMe,
    };
  }
}
