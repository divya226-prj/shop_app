import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/details_screen.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/providers/application_provider.dart';
import 'package:shop_app/providers/auth_provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: ApplicationProvider().userStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final doc = snapshot.data!;
            if (!doc.exists || doc.data() == null) {
              return Column(
                children: [const Center(child: Text("No user data found"))],
              );
            }

            final data = doc.data() as Map<String, dynamic>;
            final username = data.containsKey("username")
                ? data["username"]
                : "Guest";
            final email = data.containsKey("email")
                ? data["email"]
                : "No email";

            return _buildcolumn(context, username, email);
          },
        ),
      ),
    );
  }

  Widget _buildlogoutbutton(BuildContext context) => InkWell(
    onTap: () {
      Provider.of<AuthProvider>(context, listen: false).logout();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    },
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
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.primary,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  Widget _buildtxtmydetails(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsScreen()),
      );
    },
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.badge_outlined),
        title: Text(
          "My Details",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    ),
  );
  Widget _buildtxtemail(BuildContext context, String? email) =>
      Text(email ?? "", style: Theme.of(context).textTheme.bodyMedium);
  Widget get _buildediticon => Icon(Icons.edit_outlined);
  Widget _buildtxtusername(BuildContext context, String? username) => Text(
    username ?? "",
    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
  );
  Widget get _buildimage => Container(
    height: 70,
    width: 70,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(AppImage.profile, fit: BoxFit.cover),
    ),
  );
  Widget _buildcontainer(
    BuildContext context,
    String? username,
    String? email,
  ) => Container(
    margin: EdgeInsets.all(30),
    child: Row(
      children: [
        _buildimage,
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [_buildtxtusername(context, username), _buildediticon],
            ),
            SizedBox(height: 10),
            _buildtxtemail(context, email),
          ],
        ),
      ],
    ),
  );
  Widget _buildcolumn(context, String? username, String? email) => Column(
    children: [
      _buildcontainer(context, username, email),
      SizedBox(height: 30),
      Divider(color: Color(0xFFE2E2E2)),
      _buildtxtmydetails(context),
      Divider(color: AppColor.textontertiary),
      Spacer(),
      _buildlogoutbutton(context),
    ],
  );
}
