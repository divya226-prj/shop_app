import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';

class AppTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? obsecureText;
  final bool? enabled;
  const AppTextfield({
    super.key,

    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obsecureText = false,
    this.enabled,
  });

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obsecureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.black, fontSize: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.textPrimary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.textSecondary),
          ),
        ),
      ),
      child: TextField(
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: _obscureText ?? false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.textSecondary),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColor.subtext,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, size: 24)
              : null,
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  color: AppColor.tertiary,
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : (widget.suffixIcon != null
                    ? Icon(widget.suffixIcon, size: 24)
                    : null),

          prefixIconColor: AppColor.tertiary,
          suffixIconColor: AppColor.tertiary,
        ),
      ),
    );
  }
}
