import 'package:flutter/material.dart';
import 'package:shop_app/bottom_navbar.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/forgot_password.dart';
import 'package:shop_app/home_page.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/widgets/app_textfield.dart';
import 'package:shop_app/widgets/styled_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTxtWelcomeBack(context),
              SizedBox(height: 20),
              _buildTxtFieldEmail(context),
              SizedBox(height: 30),
              _buildTxtFieldPassword(context),

              // SizedBox(height: 10),
              _buildTxtForgotPassword(context),
              SizedBox(height: 20),
              _buildLogin(context),
              SizedBox(height: 80),
              _buildOrTxt,
              SizedBox(height: 20),
              _buildSocialRow(context),
              SizedBox(height: 20),
              _buildSignup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildOrTxt => Center(
    child: Text(
      "- OR Continue with -",
      style: TextStyle(
        color: AppColor.textonprimary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  Widget _buildTxtForgotPassword(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.0,
          ),
        ),
      ),
    ],
  );

  Widget _buildSocialRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _setSocialLogo(AppImage.google),
      SizedBox(width: 10),
      _setSocialLogo(AppImage.apple),
      SizedBox(width: 10),
      _setSocialLogo(AppImage.facebook),
    ],
  );

  Widget _buildLogin(BuildContext context) => CustomButton("Login", () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
    );
  });

  Widget _buildSignup(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Create an account ",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: AppColor.primary,
              decorationThickness: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildTxtWelcomeBack(BuildContext context) => Text(
    "Welcome \nBack!",
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
    ),
  );

  Widget _buildTxtFieldEmail(BuildContext context) => AppTextfield(
    controller: _emailController,
    hintText: "Username or Email",
    prefixIcon: Icons.person,
  );

  Widget _buildTxtFieldPassword(BuildContext context) => AppTextfield(
    controller: _passwordController,
    hintText: "Password",
    prefixIcon: Icons.lock,
    suffixIcon: Icons.visibility,
    obsecureText: true,
  );

  Widget _setSocialLogo(String? name) => Container(
    height: 54,
    width: 54,
    decoration: BoxDecoration(
      color: const Color.fromARGB(99, 241, 173, 185),
      borderRadius: BorderRadius.all(Radius.circular(360)),
      border: Border.all(color: AppColor.primary),
    ),
    child: Image.asset(name ?? ""),
  );
}
