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
        fontFamily: "Montserrat",
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColor.textSecondary,
        fontFamily: "Montserrat",
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColor.primary,
        fontFamily: "Montserrat",
      ),
      bodyLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        color: AppColor.textonsecondary,
        fontFamily: "Montserrat",
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColor.textonprimary,
        fontFamily: "Montserrat",
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.textonprimary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.textonprimary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.textPrimary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal()),
      ),
    ),
  );
}
