import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/providers/auth_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(AppImage.profile, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Username",
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(fontSize: 20),
                          ),
                          Icon(Icons.edit_outlined),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Email-id",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Divider(color: Color(0xFFE2E2E2)),
            ListTile(
              leading: Icon(Icons.badge_outlined),
              title: Text(
                "My Details",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(color: AppColor.textontertiary),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F3F2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(Icons.logout, color: AppColor.primary),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Logout",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColor.primary, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
