import 'package:flutter/material.dart';
import 'package:neurocare/Screens/home_screen.dart';
import 'package:neurocare/Widgets/bottomnavbar.dart';
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
      home: SafeArea(child: BottomNavScreen()),
    );
  }
}
