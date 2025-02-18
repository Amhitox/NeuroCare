import 'package:flutter/material.dart';
import 'package:neurocare/Screens/medication_screen.dart';
import 'package:neurocare/Screens/seizure_screen.dart';
import 'package:neurocare/Screens/setting_screen.dart';
import 'package:neurocare/utils/constants/colors.dart';

import '../Screens/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    MedicationScreen(),
    SeizureScreen(),
    SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        backgroundColor: const Color.fromARGB(157, 2, 58, 44),
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.primary,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medication), label: 'Medications'),
          BottomNavigationBarItem(icon: Icon(Icons.radio), label: 'Seizures'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings'),
        ],
      ),
    );
  }
}
