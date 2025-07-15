import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';

class Hometextfield extends StatelessWidget {
  Hometextfield({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(205, 243, 241, 241),
      ),
      child: TextField(
        controller: SearchController(),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: AppColor.textSecondary,
            size: 20,
          ),
          suffixIcon: Icon(Icons.mic, color: AppColor.textSecondary, size: 20),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          hintText: "Search any Product",
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColor.subtext,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
