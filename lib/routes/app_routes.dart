import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/views/get_started/toor_screen.dart';
import 'package:shop_app/views/home/cart_screen.dart';
import 'package:shop_app/views/home/home_page.dart';
import 'package:shop_app/views/home/product_screen.dart';
import 'package:shop_app/views/login&signup/forgot_password.dart';
import 'package:shop_app/views/login&signup/login_screen.dart';
import 'package:shop_app/views/login&signup/signup_screen.dart';
import 'package:shop_app/widgets/bottom_navbar.dart';

class AppRoutes {
  static const String first = "/";
  static const String toorScreen = "/ToorScreen";
  static const String customBottmNavBar = "/CustomBottomNavBar";
  static const String signUpScreen = "/SignUpScreen";
  static const String loginScreen = "/LoginScreen";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case first:
        return MaterialPageRoute(
          builder: (context) {
            final authProvider = Provider.of<AuthProvider>(context);
            return authProvider.user != null
                ? CustomBottomNavBar()
                : ToorScreen();
          },
        );
      case toorScreen:
        return MaterialPageRoute(builder: (_) => ToorScreen());
      case customBottmNavBar:
        return MaterialPageRoute(builder: (_) => CustomBottomNavBar());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      default:
        return MaterialPageRoute(
          builder: (context) {
            final authProvider = Provider.of<AuthProvider>(context);
            return authProvider.user != null
                ? CustomBottomNavBar()
                : ToorScreen();
          },
        );
    }
  }
}
