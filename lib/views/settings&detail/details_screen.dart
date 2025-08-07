import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/providers/application_provider.dart';
import 'package:shop_app/viewModel/settings_viewmodel.dart';
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
  String? selectedCity = "Ahmedabad";

  @override
  Widget build(BuildContext context) {
    // final settingsViewmodel = Provider.of<SettingsViewmodel>(context);
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
              final email = doc.get("email") ?? "Add your email";
              final username = doc.get("username");
              final address = doc.get("address") ?? "Empty";
              final pincode = doc.get("pincode") ?? "Empty";

              emailController.text = email;
              nameController.text = username;
              addressController.text = address;
              pincodeController.text = pincode;
              return _buildcontainer(context);
            },
          ),
        ),
      ),
    );
  }

  Widget get _buildsavebutton => CustomButton("Save", () {
    final username = nameController.text.trim();
    final address = addressController.text.trim();
    final pincode = pincodeController.text.trim();
    final provider = Provider.of<ApplicationProvider>(context, listen: false);
    if (username.isNotEmpty) {
      provider.updateUserField("username", username);
    }
    provider.updateUserField("address", address);
    provider.updateUserField("pincode", pincode);
    provider.updateUserField("country", selectedCountryKey);
    provider.updateUserField("state", selectedStateKey);
    provider.updateUserField("city", selectedCity);
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
  Widget get _buildstatedropdowncity => StateDropdownfield(
    value: selectedCityKey,
    items: worldData[selectedCountryKey]![selectedStateKey]!.entries.map((
      entry,
    ) {
      return DropdownMenuItem(value: entry.key, child: Text(entry.value));
    }).toList(),
    onchanged: (String? value) {
      setState(() {
        selectedCityKey = value;
        selectedCity =
            worldData[selectedCountryKey]![selectedStateKey]![selectedCityKey];
      });
    },
  );
  Widget get _buildstatedropdownstate => StateDropdownfield(
    value: selectedStateKey,
    items: worldData[selectedCountryKey]!.keys.map((entry) {
      return DropdownMenuItem(value: entry, child: Text(entry));
    }).toList(),
    onchanged: (String? value) {
      setState(() {
        selectedStateKey = value;
        selectedCityKey = worldData[selectedCountryKey]![value]!.keys.first;
      });
    },
  );
  Widget get _buildstatedropdowncountry => StateDropdownfield(
    value: selectedCountryKey,
    items: worldData.keys.map((entry) {
      return DropdownMenuItem(value: entry, child: Text(entry));
    }).toList(),
    onchanged: (String? value) {
      setState(() {
        selectedCountryKey = value;
        selectedStateKey = worldData[value]!.keys.first;
        selectedCityKey = worldData[value]![selectedStateKey]!.keys.first;
      });
    },
  );
  Widget get _buildapptxtfieldaddresscontroller =>
      AppTextfield(controller: addressController, hintText: "");
  Widget get _buildapptxtfieldpincodecontroller =>
      AppTextfield(controller: pincodeController, hintText: "");
  Widget get _buildapptxtfieldnamecontroller =>
      AppTextfield(controller: nameController, hintText: "");
  Widget get _buildapptxtfieldemailcontroller =>
      AppTextfield(controller: emailController, hintText: "", enabled: false);
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
    child: _image == null
        ? Image.asset(AppImage.profile, fit: BoxFit.cover)
        : Image.file(_image ?? File("")),
  );
  Widget _buildcontainer(BuildContext context) => Container(
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
        _buildapptxtfieldemailcontroller,
        SizedBox(height: 15),
        _buildtxtusername(context),
        SizedBox(height: 10),
        _buildapptxtfieldnamecontroller,

        SizedBox(height: 30),

        _buildtxtaddressdetails(context),
        SizedBox(height: 30),
        _buildtxtcountry(context),

        SizedBox(height: 20),
        _buildstatedropdowncountry,

        SizedBox(height: 30),
        _buildtxtstate(context),

        SizedBox(height: 10),
        _buildstatedropdownstate,

        SizedBox(height: 30),
        _buildtxtcity(context),

        SizedBox(height: 10),
        _buildstatedropdowncity,
        SizedBox(height: 30),
        _buildtxtaddress(context),
        SizedBox(height: 10),
        _buildapptxtfieldaddresscontroller,
        SizedBox(height: 30),
        _buildtxtpincode(context),
        SizedBox(height: 10),
        _buildapptxtfieldpincodecontroller,
        SizedBox(height: 30),
        _buildsavebutton,
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
