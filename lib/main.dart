import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_theme.dart';
import 'package:shop_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}
