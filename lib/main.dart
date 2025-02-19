import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:neurocare/Screens/login_screen.dart';
import 'package:neurocare/Screens/signup_screen.dart';
import 'package:neurocare/Screens/splash_screen.dart';
import 'package:neurocare/Widgets/bottomnavbar.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: SafeArea(child: SplashScreen()),
    );
  }
}
