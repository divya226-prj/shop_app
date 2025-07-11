import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/get_started.dart';

class ToorScreen extends StatefulWidget {
  const ToorScreen({super.key});

  @override
  State<ToorScreen> createState() => _toorScreen1State();
}

class _toorScreen1State extends State<ToorScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int _currentPage = 0;
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
    return Scaffold(backgroundColor: Colors.white, body: _buildcolumn);
  }

  Widget _tourView(int index) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(tourData[index]['image'] ?? "", height: 300),
        Text(
          (tourData[index]['title'] ?? ""),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 30),
        //
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            tourData[index]['desc'] ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 15, color: Colors.grey),
          ),
        ),
      ],
    ),
  );

  Widget _buildtextbutton(context) => TextButton(
    onPressed: () {
      if (_currentPage == tourData.length - 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GetStarted()),
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    },
    child: Text(
      _currentPage == tourData.length - 1 ? "Get Started" : "Next",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColor.primary,
      ),
    ),
  );

  Widget get _buildrow => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(tourData.length, (indexDot) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: _currentPage == indexDot ? 40 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: _currentPage == indexDot
              ? AppColor.textPrimary
              : AppColor.textSecondary,
          borderRadius: BorderRadius.circular(5),
        ),
      );
    }),
  );

  Widget get _buildtext => _currentPage > 0
      ? TextButton(
          onPressed: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text(
            "Prev",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        )
      : SizedBox(width: 60);

  Widget get _buildcontainer => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_buildtext, _buildrow, _buildtextbutton(context)],
    ),
  );

  Widget get _buildpageview => Flexible(
    child: PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      children: List.generate(tourData.length, (index) => _tourView(index)),
      // children: [_tourView(0), _tourView(1), _tourView(2)],
    ),
  );

  Widget _buildbutton(context) => TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
    },
    child: Text(
      "Skip",
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(color: Color(0xFF000000), fontSize: 19),
    ),
  );

  Widget _buildtoordatatext(context) => Text(
    "${tourData.length}",
    style: Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: Colors.grey, fontSize: 20),
  );

  Widget get _buildcurrenttext => Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${_currentPage + 1}/",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.black, fontSize: 20),
        ),

        _buildtoordatatext(context),
        Spacer(),
        _buildbutton(context),
      ],
    ),
  );

  Widget get _buildcolumn => SafeArea(
    child: Column(
      children: [_buildcurrenttext, _buildpageview, _buildcontainer],
    ),
  );
}
