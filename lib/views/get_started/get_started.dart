import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/routes/app_routes.dart';
import 'package:shop_app/widgets/styled_button.dart';

import 'package:shop_app/views/login&signup/signup_screen.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.textPrimary, Colors.transparent],
              ),
            ),
            child: _buildbgimg,
          ),
          _buildcontent,
        ],
      ),
    );
  }

  Widget get _buildbodytext => Text(
    "Find it here,buy it now!",
    textAlign: TextAlign.center,
    style: Theme.of(context).textTheme.bodyMedium,
  );

  Widget get _buildtitle => SizedBox(
    width: 315,
    child: Center(
      child: Text(
        textAlign: TextAlign.center,
        "You want \nauthentic,here you go!",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ),
  );

  Widget get _buildcontent => Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildtitle,
          SizedBox(height: 10),
          _buildbodytext,
          SizedBox(height: 30),
          CustomButton("Get Started", () {
            Navigator.pushNamed(context, AppRoutes.signUpScreen);
          }),
        ],
      ),
    ),
  );
  Widget get _buildbgimg => SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Image.asset(AppImage.getstarted, fit: BoxFit.cover),
  );
}
