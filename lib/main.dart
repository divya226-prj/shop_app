import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bottom_navbar.dart';
import 'package:shop_app/constants/app_theme.dart';
import 'package:shop_app/get_started.dart';
import 'package:shop_app/providers/application_provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/splash_screen.dart';
import 'package:shop_app/toor_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: authProvider.user != null ? CustomBottomNavBar() : ToorScreen(),
      theme: AppTheme.lightTheme,
    );
  }
}
