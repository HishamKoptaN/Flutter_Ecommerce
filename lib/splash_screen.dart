import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const LoginPage(),
        //     ),
        //     (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AvatarGlow(
          glowColor: AppColors.backGroundColor,
          endRadius: 200.0,
          duration: const Duration(milliseconds: 1000),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: const Duration(milliseconds: 300),
          child: Material(
            elevation: 5.0,
            shape: const CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/logo.png',
                height: 650,
                width: 650,
              ),
              radius: 100,
            ),
          ),
        ),
      ),
    );
  }
}
