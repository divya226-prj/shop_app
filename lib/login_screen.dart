import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bottom_navbar.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/forgot_password.dart';
import 'package:shop_app/home_page.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/signup_screen.dart';
import 'package:shop_app/social_logo.dart';
import 'package:shop_app/widgets/app_textfield.dart';
import 'package:shop_app/widgets/styled_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
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

                    SizedBox(height: 10),
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
          ),
        ),
        if (isLoading)
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          ),
      ],
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
      SocialLogo(AppImage.google, () async {
        setState(() {
          isLoading = true;
        });
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final result = await authProvider.signInWithGoogle();
        setState(() {
          isLoading = false;
        });
        if (result == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login successfully")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => CustomBottomNavBar()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Not able to signin with google")),
          );
        }
      }),
      SizedBox(width: 10),
      SocialLogo(AppImage.apple, () {}),
      SizedBox(width: 10),
      SocialLogo(AppImage.facebook, () async {
        setState(() {
          isLoading = true;
        });
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final result = await authProvider.signInWithFacebook();
        setState(() {
          isLoading = false;
        });
        if (result == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login successfully")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => CustomBottomNavBar()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Not able to login with facebook")),
          );
        }
      }),
    ],
  );

  Widget _buildLogin(BuildContext context) => CustomButton("Login", () async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String? result = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (result == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => CustomBottomNavBar()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
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
              MaterialPageRoute(builder: (context) => SignupScreen()),
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
}
