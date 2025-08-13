import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/providers/application_provider.dart';
import 'package:shop_app/viewModel/settings_viewmodel.dart';
import 'package:shop_app/views/settings&detail/settings.dart';
import 'package:shop_app/widgets/app_textfield.dart';
import 'package:shop_app/widgets/state_dropdown.dart';
import 'package:shop_app/widgets/styled_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsViewmodel = Provider.of<SettingsViewmodel>(
      context,
      listen: true,
    );
    final appProvider = Provider.of<ApplicationProvider>(
      context,
      listen: false,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: _buildappbar,
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

              final data = doc.data() as Map<String, dynamic>? ?? {};

              final country = data["country"] as String?;
              final state = data["state"] as String?;
              final city = data["city"] as String?;

              if (country != null &&
                  settingsViewmodel.worldData.containsKey(country) &&
                  settingsViewmodel.selectedCountryKey == 'India') {
                settingsViewmodel.selectedCountryKey = country;
              }

              if (state != null &&
                  settingsViewmodel
                      .worldData[settingsViewmodel.selectedCountryKey]!
                      .containsKey(state) &&
                  settingsViewmodel.selectedStateKey == 'Gujarat') {
                settingsViewmodel.selectedStateKey = state;
              }

              if (city != null &&
                  settingsViewmodel
                      .worldData[settingsViewmodel
                          .selectedCountryKey]![settingsViewmodel
                          .selectedStateKey]!
                      .containsValue(city) &&
                  settingsViewmodel.selectedCityKey == 'A') {
                settingsViewmodel.selectedCityKey = settingsViewmodel
                    .worldData[settingsViewmodel
                        .selectedCountryKey]![settingsViewmodel
                        .selectedStateKey]!
                    .entries
                    .firstWhere((entry) => entry.value == city)
                    .key;
                settingsViewmodel.selectedCity = city;
              }

              final email = doc.get("email") ?? "Add your email";
              final username = doc.get("username");

              if (data.containsKey("address")) {
                final address = data["address"];
                settingsViewmodel.addressController.text = address;
              }
              if (data.containsKey("pincode")) {
                final pincode = data["pincode"];
                settingsViewmodel.pincodeController.text = pincode;
              }

              settingsViewmodel.emailController.text = email;
              settingsViewmodel.nameController.text = username;
              return _buildcontainer(context, settingsViewmodel);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildsavebutton(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => CustomButton("Save", () {
    final username = settingsViewmodel.nameController.text.trim();
    final address = settingsViewmodel.addressController.text.trim();
    final pincode = settingsViewmodel.pincodeController.text.trim();
    final provider = Provider.of<ApplicationProvider>(context, listen: false);
    if (username.isNotEmpty) {
      provider.updateUserField("username", username);
    }
    provider.updateUserField("address", address);
    provider.updateUserField("pincode", pincode);
    provider.updateUserField("country", settingsViewmodel.selectedCountryKey);
    provider.updateUserField("state", settingsViewmodel.selectedStateKey);
    provider.updateUserField("city", settingsViewmodel.selectedCity);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Changes saved succefully")));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Settings()),
    );
  });
  Widget _buildtxtcity(BuildContext context) => Text(
    "City",
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColor.subtext,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _buildtxtstate(BuildContext context) => Text(
    "State",
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColor.subtext,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _buildtxtcountry(BuildContext context) => Text(
    "Country",
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColor.subtext,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _buildtxtaddress(BuildContext context) => Text(
    "Address",
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColor.subtext,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _buildtxtpincode(BuildContext context) => Text(
    "Pincode",
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColor.subtext,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _buildtxtaddressdetails(BuildContext context) => Text(
    "Address Details",
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColor.textPrimary,
    ),
  );
  Widget _buildtxtusername(BuildContext context) => Text(
    "Username",
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColor.subtext,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _buildtxtemailaddress(BuildContext context) => Text(
    "Email Address",
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColor.subtext,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _buildtxtpersonalDetails(BuildContext context) => Text(
    "Personal Details",
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColor.textPrimary,
    ),
  );
  Widget _buildstatedropdowncity(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => StateDropdownfield(
    value: settingsViewmodel.selectedCityKey,
    items: settingsViewmodel
        .worldData[settingsViewmodel.selectedCountryKey]![settingsViewmodel
            .selectedStateKey]!
        .entries
        .map((entry) {
          return DropdownMenuItem(value: entry.key, child: Text(entry.value));
        })
        .toList(),
    onchanged: (value) {
      settingsViewmodel.setCityKey(value);
    },
  );
  Widget _buildstatedropdownstate(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => StateDropdownfield(
    value: settingsViewmodel.selectedStateKey,
    items: settingsViewmodel
        .worldData[settingsViewmodel.selectedCountryKey]!
        .keys
        .map((entry) {
          return DropdownMenuItem(value: entry, child: Text(entry));
        })
        .toList(),
    onchanged: (value) {
      settingsViewmodel.setStateKey(value);
    },
  );
  Widget _buildstatedropdowncountry(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => StateDropdownfield(
    value: settingsViewmodel.selectedCountryKey,
    items: settingsViewmodel.worldData.keys.map((entry) {
      return DropdownMenuItem(value: entry, child: Text(entry));
    }).toList(),
    onchanged: (value) {
      settingsViewmodel.setCountryKey(value);
    },
  );
  Widget _buildapptxtfieldaddresscontroller(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => AppTextfield(
    controller: settingsViewmodel.addressController,
    hintText: "",
  );
  Widget _buildapptxtfieldpincodecontroller(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => AppTextfield(
    controller: settingsViewmodel.pincodeController,
    hintText: "",
  );
  Widget _buildapptxtfieldnamecontroller(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => AppTextfield(controller: settingsViewmodel.nameController, hintText: "");
  Widget _buildapptxtfieldemailcontroller(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => AppTextfield(
    controller: settingsViewmodel.emailController,
    hintText: "",
    enabled: false,
  );
  Widget get _buildicon =>
      Icon(Icons.edit_outlined, color: AppColor.textonsecondary, size: 15);
  Widget get _buildpositioned => Positioned(
    right: 0,
    bottom: 0,
    child: Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: AppColor.texttertiary,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColor.textonsecondary, width: 4),
      ),
      child: _buildicon,
    ),
  );
  Widget get _buildimgcontainer => Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
    child: Image.asset(AppImage.profile, fit: BoxFit.cover),
  );
  Widget _buildcontainer(
    BuildContext context,
    SettingsViewmodel settingsViewmodel,
  ) => Container(
    margin: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Center(child: Stack(children: [_buildimgcontainer, _buildpositioned])),

        SizedBox(height: 40),
        _buildtxtpersonalDetails(context),
        SizedBox(height: 15),
        _buildtxtemailaddress(context),
        SizedBox(height: 10),
        _buildapptxtfieldemailcontroller(context, settingsViewmodel),
        SizedBox(height: 15),
        _buildtxtusername(context),
        SizedBox(height: 10),
        _buildapptxtfieldnamecontroller(context, settingsViewmodel),

        SizedBox(height: 30),

        _buildtxtaddressdetails(context),
        SizedBox(height: 30),
        _buildtxtcountry(context),

        SizedBox(height: 20),
        _buildstatedropdowncountry(context, settingsViewmodel),

        SizedBox(height: 30),
        _buildtxtstate(context),

        SizedBox(height: 10),
        _buildstatedropdownstate(context, settingsViewmodel),

        SizedBox(height: 30),
        _buildtxtcity(context),

        SizedBox(height: 10),
        _buildstatedropdowncity(context, settingsViewmodel),
        SizedBox(height: 30),
        _buildtxtaddress(context),
        SizedBox(height: 10),
        _buildapptxtfieldaddresscontroller(context, settingsViewmodel),
        SizedBox(height: 30),
        _buildtxtpincode(context),
        SizedBox(height: 10),
        _buildapptxtfieldpincodecontroller(context, settingsViewmodel),
        SizedBox(height: 30),
        _buildsavebutton(context, settingsViewmodel),
      ],
    ),
  );
  PreferredSizeWidget get _buildappbar => AppBar(
    automaticallyImplyLeading: true,
    title: Text(
      "My Details",
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
    ),
  );
}
