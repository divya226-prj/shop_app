import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/widgets/app_textfield.dart';
import 'package:shop_app/widgets/styled_button.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 30),
                _buildTxtCreateAccount(context),
                SizedBox(height: 30),
                _buildTxtFieldEmail(context),
                SizedBox(height: 30),
                _buildTxtFieldPassword(context),
                SizedBox(height: 30),
                _buildTxtConfirmFieldPassword(context),
                SizedBox(height: 30),
                _buildTxtPublicOffer(context),
                SizedBox(height: 30),
                _buildCreateAccount(context),
                SizedBox(height: 30),
                _buildOrTxt,
                SizedBox(height: 20),
                _buildSocialRow(context),
                SizedBox(height: 20),
                _buildLogin(context),
                // SizedBox(height: 40),
              ],
            ),
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

  Widget _buildTxtPublicOffer(BuildContext context) => RichText(
    text: TextSpan(
      text: "By clicking the ",
      style: TextStyle(
        color: AppColor.subtext,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.0,
      ),
      children: <TextSpan>[
        TextSpan(
          text: "Register",
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.0,
          ),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
        TextSpan(
          text: " button, you agree \nto the public offer",
          style: TextStyle(
            color: AppColor.subtext,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
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

  Widget _buildCreateAccount(BuildContext context) =>
      CustomButton("Create Account", () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });

  Widget _buildLogin(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "I Already Have an Account ",
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
            "Login",
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

  Widget _buildTxtCreateAccount(BuildContext context) => Text(
    "Create an \naccount",
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

  Widget _buildTxtConfirmFieldPassword(BuildContext context) => AppTextfield(
    controller: _confirmpasswordController,
    hintText: "Confirm Password",
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
