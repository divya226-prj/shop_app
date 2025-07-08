import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(primary: AppColor.primary),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: AppColor.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColor.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
      ),
    ),
  );
}
