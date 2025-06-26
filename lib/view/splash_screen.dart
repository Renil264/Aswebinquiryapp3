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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FractionallySizedBox(
          widthFactor: 0.3,
          child: AspectRatio(
            aspectRatio: 1,
            child: SvgPicture.asset(
              'assets/logo.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'AntiqueSoft',
          style: TextStyle(
            color: Color(0xFF0C2A5D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Text(
          'Web Inquiry',
          style: TextStyle(
            color: Color(0xFF0C2A5D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
