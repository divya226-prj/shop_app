import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/providers/application_provider.dart';
import 'package:shop_app/widgets/app_textfield.dart';
import 'package:shop_app/widgets/state_dropdown.dart';
import 'package:shop_app/widgets/styled_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<ApplicationProvider>(
      context,
      listen: false,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "My Details",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: appProvider.userStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final doc = snapshot.data!;
              if (!doc.exists) {
                return Text("No Data found");
              }
              final email = doc.get("email") ?? "Add your email";
              final username = doc.get("username");
              emailController.text = email;
              nameController.text = username;
              return Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.asset(
                              AppImage.profile,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: AppColor.texttertiary,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: AppColor.textonsecondary,
                                  width: 4,
                                ),
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                color: AppColor.textonsecondary,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),
                    Text(
                      "Personal Details",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Email Address",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(
                      controller: emailController,
                      hintText: "",
                      enabled: false,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Username",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(controller: nameController, hintText: ""),

                    SizedBox(height: 30),
                    Text(
                      "Address Details",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Pincode",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(controller: pincodeController, hintText: ""),
                    SizedBox(height: 20),
                    Text(
                      "Address",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(controller: addressController, hintText: ""),
                    SizedBox(height: 20),
                    Text(
                      "City",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(controller: cityController, hintText: ""),
                    SizedBox(height: 20),
                    Text(
                      "State",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    StateDropdownfield(),
                    SizedBox(height: 20),
                    Text(
                      "Country",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(controller: countryController, hintText: ""),
                    SizedBox(height: 20),
                    CustomButton("Save", () {
                      final username = nameController.text.trim();
                      if (username.isNotEmpty) {
                        Provider.of<ApplicationProvider>(
                          context,
                          listen: false,
                        ).updateUserField("username", username);
                      }
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
