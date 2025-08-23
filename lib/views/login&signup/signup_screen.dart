import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/routes/app_routes.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/views/login&signup/widget/social_logo.dart';
import 'package:shop_app/widgets/app_textfield.dart';
import 'package:shop_app/widgets/styled_button.dart';
import 'package:shop_app/widgets/textfield_validaters.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

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
                    ],
                  ),
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
          Navigator.pushNamed(context, AppRoutes.customBottmNavBar);
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
        if (result == "success") {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login successful")));
          Navigator.pushNamed(context, AppRoutes.customBottmNavBar);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result ?? "Facebook login failed")),
          );
        }
      }),
    ],
  );

  Widget _buildCreateAccount(BuildContext context) => CustomButton(
    "Create Account",
    () async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmpasswordController.text.trim();
      final emailError = TextfieldValidaters.emailValidator(email);
      final passwordError = TextfieldValidaters.passwordValidator(password);
      final confirmpasswordError = TextfieldValidaters.confirmpasswordValidator(
        confirmPassword,
        password,
      );

      if (emailError != null ||
          passwordError != null ||
          confirmpasswordError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(emailError ?? confirmpasswordError ?? passwordError!),
          ),
        );
      }

      String? result = await authProvider.signup(email, password);

      if (result == null) {
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result)));
      }
    },
  );

  Widget _buildLogin(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "I Already Have an Account ",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.loginScreen);
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
}
