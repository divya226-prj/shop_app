import 'dart:io';

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
  final Map<String, Map<String, Map<String, String>>> worldData = {
    'India': {
      'Gujarat': {
        'A': 'Ahmedabad ',
        'S': 'Surat',
        'R': 'Rajkot',
        'v': 'Vadodra',
      },
      'Maharashtra': {
        'A': 'Aurangabad',
        'K': 'Kolhapur',
        'S': 'Solapur',
        'N': 'Nashik',
      },
      'Rajasthan': {
        'P': 'Pushkar',
        'U': 'Udaipur',
        'A': 'Ajmer',
        'B': 'Bikaner',
      },
      'Uttar Pradesh': {
        'M': 'Meerut',
        'A': 'Agra',
        'P': 'Prayagraj',
        'B': 'Bareilly',
      },
    },
    'United Kingdom': {
      'England': {
        'l': 'London',
        'm': 'Manchester',
        'b': 'Birmingham',
        'liverpool': 'Liverpool',
      },
      'Scotland': {
        'e': 'Edinburgh',
        'g': 'Glasgow',
        'a': 'Aberdeen',
        'd': 'Dundee',
      },
      'Wales': {'c': 'Cardiff', 's': 'Swansea', 'n': 'Newport', 'w': 'Wrexham'},
      'Nothern Ireland': {
        'b': 'Belfast',
        'd': 'Derry',
        'n': 'Newry',
        'l': 'Lisburn',
      },
    },
    'Canada': {
      'Ontario': {
        't': 'Toronto',
        'o': 'Ottawa',
        'k': 'Kitchener',
        'h': 'Hamilton',
      },
      'Quebec': {
        'm': 'Montreal',
        'q': 'Quebec City',
        'l': 'Laval',
        'g': 'Gatineau',
      },
      'British Columbia': {
        'v': 'Vancouver',
        's': 'Surrey',
        'b': 'Burnaby',
        'r': 'Richmond',
      },
      'Alberta': {
        'c': 'Calgary',
        'e': 'Edmonton',
        'l': 'Lethbridge',
        's': 'St. Albert',
      },
    },
    'United States': {
      'California': {
        'l': 'Los Angeles',
        's': 'San Francisco',
        's2': 'San Diego',
        's3': 'Sacramento',
      },
      'Texas': {
        'h': 'Houston',
        'd': 'Dallas',
        'a': 'Austin',
        'f': 'Fort Worth',
      },
      'Florida': {
        'm': 'Miami',
        'o': 'Orlando',
        't': 'Tampa',
        'j': 'Jacksonville',
      },
      'New York': {
        'n': 'New York City',
        'b': 'Buffalo',
        'r': 'Rochester',
        's': 'Syracuse',
      },
    },
  };
  File? _image;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String? selectedStateKey = "Gujarat";
  String? selectedCountryKey = 'India';
  String? selectedCityKey = 'A';

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
                            child: _image == null
                                ? Image.asset(
                                    AppImage.profile,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(_image ?? File("")),
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
                    SizedBox(height: 30),
                    Text(
                      "Pincode",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(controller: pincodeController, hintText: ""),
                    SizedBox(height: 30),
                    Text(
                      "Address",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    AppTextfield(controller: addressController, hintText: ""),
                    SizedBox(height: 30),
                    Text(
                      "Country",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 20),
                    StateDropdownfield(
                      value: selectedCountryKey,
                      items: worldData.keys.map((entry) {
                        return DropdownMenuItem(
                          value: entry,
                          child: Text(entry),
                        );
                      }).toList(),
                      onchanged: (String? value) {
                        setState(() {
                          selectedCountryKey = value;
                          selectedStateKey = worldData[value]!.keys.first;
                          selectedCityKey =
                              worldData[value]![selectedStateKey]!.keys.first;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      "State",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    StateDropdownfield(
                      value: selectedStateKey,
                      items: worldData[selectedCountryKey]!.keys.map((entry) {
                        return DropdownMenuItem(
                          value: entry,
                          child: Text(entry),
                        );
                      }).toList(),
                      onchanged: (String? value) {
                        setState(() {
                          selectedStateKey = value;
                          selectedCityKey =
                              worldData[selectedCountryKey]![value]!.keys.first;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      "City",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.subtext,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),

                    _buildstatedropdownfield,
                    SizedBox(height: 30),
                    _buildsavebutton,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get _buildsavebutton => CustomButton("Save", () {
    final username = nameController.text.trim();
    if (username.isNotEmpty) {
      Provider.of<ApplicationProvider>(
        context,
        listen: false,
      ).updateUserField("username", username);
    }
  });
  Widget get _buildstatedropdownfield => StateDropdownfield(
    value: selectedCityKey,
    items: worldData[selectedCountryKey]![selectedStateKey]!.entries.map((
      entry,
    ) {
      return DropdownMenuItem(value: entry.key, child: Text(entry.value));
    }).toList(),
    onchanged: (String? value) {
      setState(() {
        selectedCityKey = value;
      });
    },
  );
}
