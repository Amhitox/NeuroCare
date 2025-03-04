import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:neurocare/Screens/Static/onboarding.dart';
import 'package:neurocare/utils/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 2000,
        splash: Image.asset(
          'assets/images/logo.png',
          height: 300,
        ),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.background,
        nextScreen: OnBoarding(),
      ),
    );
  }
}
