import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';

class SocialLogo extends StatelessWidget {
  const SocialLogo(this.imageName, this.onTap, {super.key});
  final void Function() onTap;
  final String? imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          color: const Color.fromARGB(99, 241, 173, 185),
          borderRadius: BorderRadius.all(Radius.circular(360)),
          border: Border.all(color: AppColor.primary),
        ),
        child: Image.asset(imageName ?? ""),
      ),
    );
  }

  // Widget _setSocialLogo(String? name) =>
}
