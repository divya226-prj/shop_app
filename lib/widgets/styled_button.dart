import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.btntext, this.onTap, {super.key});
  final String btntext;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        child: Center(
          child: Text(
            btntext,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 23),
          ),
        ),
      ),
    );
  }
}
