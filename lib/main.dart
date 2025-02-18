import 'package:flutter/material.dart';
import 'package:neurocare/Screens/splash_screen.dart';
import 'utils/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SafeArea(child: SplashScreen()),
    );
  }
}
