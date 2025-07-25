import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/widgets/app_textfield.dart';
import 'package:shop_app/widgets/styled_button.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  ForgotPassword({super.key});

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
              _buildTxtForgotPassword(context),
              SizedBox(height: 30),
              _buildTxtFieldEmail(context),
              SizedBox(height: 30),

              _buildTxtNewPassword(context),
              SizedBox(height: 30),
              _buildSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTxtNewPassword(BuildContext context) => Row(
    // mainAxisAlignment: MainAxisAlignment.end,
    children: [
      // SizedBox(height: 20),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "*",
              style: TextStyle(color: AppColor.primary),
            ),
            TextSpan(
              text:
                  "We will send you a message to set or reset \nyour new password",
              style: TextStyle(
                color: AppColor.subtext,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildSubmit(BuildContext context) =>
      CustomButton("Submit", () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });

  Widget _buildTxtForgotPassword(BuildContext context) => Text(
    "Forgot \npassword?",
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
    ),
  );

  Widget _buildTxtFieldEmail(BuildContext context) => AppTextfield(
    controller: _emailController,
    hintText: "Enter your email address",
    prefixIcon: Icons.mail,
  );
}
