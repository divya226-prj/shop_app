import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/widgets/hometextfield.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildappbar, body: _buildcolumnhometxtfield);
  }

  Widget get _buildcolumnhometxtfield => Column(
    children: [
      SizedBox(height: 20),
      Hometextfield(controller: searchController, onchanged: (value) {}),
    ],
  );
  Widget get _buildcircleavatar =>
      CircleAvatar(backgroundImage: AssetImage(AppImage.profile), radius: 16);
  Widget get _builappbaricon => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [Image.asset(AppImage.applogo, height: 31)],
  );
  Widget get _buildappbariconbutton => IconButton(
    icon: Icon(Icons.menu, color: Colors.black),
    onPressed: () {},
  );
  PreferredSizeWidget get _buildappbar => AppBar(
    leading: _buildappbariconbutton,
    title: _builappbaricon,
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: _buildcircleavatar,
      ),
    ],
  );
}
