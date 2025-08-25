import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/routes/app_routes.dart';
import 'package:shop_app/viewModel/settings_viewmodel.dart';
import 'package:shop_app/views/home/home_page.dart';
import 'package:shop_app/views/home/search_screen.dart';
import 'package:shop_app/views/login&signup/forgot_password.dart';
import 'package:shop_app/views/login&signup/login_screen.dart';
import 'package:shop_app/views/login&signup/signup_screen.dart';
import 'package:shop_app/widgets/bottom_navbar.dart';
import 'package:shop_app/constants/app_theme.dart';
import 'package:shop_app/providers/application_provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/views/get_started/toor_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsViewmodel()),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop app',
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.first,

      theme: AppTheme.lightTheme,
    );
  }
}
