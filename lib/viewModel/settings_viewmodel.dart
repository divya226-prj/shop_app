import 'package:flutter/material.dart';

class SettingsViewmodel extends ChangeNotifier {
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

  void setCountryKey(String? value) {
    selectedCountryKey = value;
    selectedStateKey = worldData[value]!.keys.first;
    selectedCityKey = worldData[value]![selectedStateKey]!.keys.first;
    selectedCity = worldData[value]![selectedStateKey]![selectedCityKey];
    notifyListeners();
  }

  void setStateKey(String? value) {
    selectedStateKey = value;
    selectedCityKey = worldData[selectedCountryKey]![value]!.keys.first;
    selectedCity = worldData[selectedCountryKey]![value]![selectedCityKey];
    notifyListeners();
  }

  void setCityKey(String? value) {
    selectedCityKey = value;
    selectedCity = worldData[selectedCountryKey]![selectedStateKey]![value];
    notifyListeners();
  }
}
