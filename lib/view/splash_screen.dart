import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:antiquewebemquiry/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _buildLogoWithText(),
      ),
    );
  }

  Widget _buildLogoWithText() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double scaleFactor = screenWidth / 422; // Base width scaling

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FractionallySizedBox(
              widthFactor: 0.20, // 30% of screen width
              child: AspectRatio(
                aspectRatio: 1, // Maintain square logo shape
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 8 * scaleFactor),
            Text(
              'AntiqueSoft',
              style: TextStyle(
                color: const Color(0xFF0C2A5D),
                fontWeight: FontWeight.bold,
                fontSize: 16 * scaleFactor,
              ),
            ),
            Text(
              'Web Inquiry',
              style: TextStyle(
                color: const Color(0xFF0C2A5D),
                fontWeight: FontWeight.bold,
                fontSize: 16 * scaleFactor,
              ),
            ),
          ],
        );
      },
    );
  }
}
