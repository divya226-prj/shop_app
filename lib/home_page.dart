import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/bottom_navbar.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/hometextfield.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [Image.asset(AppImage.applogo, height: 31)],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundImage: AssetImage(AppImage.profile),
              radius: 16,
            ),
          ),
        ],
      ),

      body: Column(children: [SizedBox(height: 20), Hometextfield()]),
    );
  }
}
