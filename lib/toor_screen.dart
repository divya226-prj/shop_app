import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/custom_text.dart';

class ToorScreen extends StatefulWidget {
  const ToorScreen({super.key});

  @override
  State<ToorScreen> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<ToorScreen> {
  final List<Map<String, String>> tourData = [
    {
      "image": AppImage.fashion,
      "title": "Choose Products",
      "desc":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    },
    {
      "image": AppImage.payment,
      "title": "Make Payment",
      "desc":
          "Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt.",
    },
    {
      "image": AppImage.order,
      "title": "Get Your Order",
      "desc":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: [_tourView(0), _tourView(1), _tourView(2)],
        ),
      ),
    );
  }

  Widget _tourView(int index) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(height: 100),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "1/",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              Text(
                "3",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Text(
                "Skip",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Color(0xFF000000),
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 150),
        Image.asset(tourData[index]['image'] ?? ""),
        Text(
          (tourData[index]['title'] ?? ""),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 30),
        CustomText(),
        SizedBox(height: 150),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Image.asset(AppImage.circle),
              Text("Next", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    ),
  );
}
