import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [_buildbgimg, _buildcontent]));
  }

  Widget _buildbutton(BuildContext context) => SizedBox(
    width: 279,
    height: 60,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal()),
      ),
      child: Text(
        textAlign: TextAlign.center,
        "Get Started",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 23),
      ),
    ),
  );

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
          _buildbutton(context),
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
