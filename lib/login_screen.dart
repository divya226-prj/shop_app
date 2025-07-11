import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(
            "Welcome \nBack",
            style: TextStyle(color: AppColor.textPrimary),
          ),
        ),
      ),
    );
  }
}
