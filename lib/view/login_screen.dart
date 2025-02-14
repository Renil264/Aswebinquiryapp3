import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _formSlideAnimation;
  late Animation<double> _formFadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), // Total animation duration
    );

    // Logo animations (0 to 1 second)
    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    // Form animations (1 to 2 seconds)
    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    _formFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    // Start the animation when the screen loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              // Animated Logo Section
              SlideTransition(
                position: _logoSlideAnimation,
                child: FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Animated Form Section
              SlideTransition(
                position: _formSlideAnimation,
                child: FadeTransition(
                  opacity: _formFadeAnimation,
                  child: Column(
                    children: [
                      _buildTextField(
                        labelText: 'Store Code',
                        iconPath: 'assets/store.png',
                        controller: loginViewModel.storeCodeController,
                      ),
                      const SizedBox(height: 23),
                      _buildTextField(
                        labelText: 'User Id',
                        iconPath: 'assets/user.png',
                        controller: loginViewModel.usernameController,
                      ),
                      const SizedBox(height: 23),
                      _buildPasswordField(
                        controller: loginViewModel.passwordController,
                        isPasswordVisible: loginViewModel.isPasswordVisible,
                        onToggleVisibility: loginViewModel.togglePasswordVisibility,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: loginViewModel.rememberMe,
                                onChanged: (_) => loginViewModel.toggleRememberMe(),
                                activeColor: const Color(0xFF172B4D),
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: Color(0xFF172B4D),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                color: Color(0xFF172B4D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 173,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool success = await loginViewModel.login(context);
                            if (!success) {
                              // ignore: use_build_context_synchronously
                              _showErrorDialog(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF8500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Login Failed',
      desc: 'Invalid credentials. Please try again.',
      btnOkOnPress: () {},
      btnOkColor: Colors.red,
    ).show();
  }

  Widget _buildTextField({
    required String labelText,
    required String iconPath,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 366,
      height: 60,
      child: TextField(
        controller: controller,
        cursorColor: const Color(0xFF172B4D),
        style: const TextStyle(color: Color(0xFF172B4D)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Color(0xFF172B4D), fontSize: 14),
          floatingLabelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(iconPath, width: 24, height: 24),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool isPasswordVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return SizedBox(
      width: 366,
      height: 60,
      child: TextField(
        controller: controller,
        obscureText: !isPasswordVisible,
        cursorColor: const Color(0xFF172B4D),
        style: const TextStyle(color: Color(0xFF172B4D)),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(color: Color(0xFF172B4D), fontSize: 14),
          floatingLabelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFFFF8500),
            ),
            onPressed: onToggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    );
  }
}