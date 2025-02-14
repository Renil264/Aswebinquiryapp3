import 'package:antiquewebemquiry/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'change_password.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7, // Set the drawer width to 70% of the screen width
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: const Color(0xFFFF8500),
                padding: const EdgeInsets.only(top: 40),
                child: const Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFFFF8500),
                ),
                title: const Text(
                  'Change Password',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16,
                    color: Color(0xFF172B4D),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Color(0xFFFF8500),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16,
                    color: Color(0xFF172B4D),
                  ),
                ),
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: 'Logout',
    desc: 'Are you sure you want to logout?',
    btnCancelText: 'No',
    btnOkText: 'Yes',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    },
  ).show();
}

}