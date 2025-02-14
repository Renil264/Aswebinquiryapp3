class ChangePasswordModel {
  String currentPassword;
  String newPassword;
  String confirmPassword;

  ChangePasswordModel({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });
}