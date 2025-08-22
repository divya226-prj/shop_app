import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';

class Hometextfield extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onchanged;

  Hometextfield({super.key, required this.controller, required this.onchanged});

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
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: onchanged,
        style: TextTheme.of(context).bodySmall?.copyWith(
          color: AppColor.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
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
