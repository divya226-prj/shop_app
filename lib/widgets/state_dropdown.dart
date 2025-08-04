import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';

class StateDropdownfield extends StatefulWidget {
  const StateDropdownfield({super.key});
  @override
  State<StateDropdownfield> createState() => _StateDropdownfieldState();
}

class _StateDropdownfieldState extends State<StateDropdownfield> {
  final Map<String, String> states = {
    'GUJ': 'Gujarat',
    'HYD': 'Hydrabad',
    'KAR': 'Karnataka',
    'UP': 'Uttar Pradesh',
  };
  String? selectedKey = 'GUJ';
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedKey,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.textPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.textSecondary),
        ),
      ),
      items: states.entries.map((entry) {
        return DropdownMenuItem(value: entry.key, child: Text(entry.value));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedKey = value;
        });
      },
    );
  }
}
