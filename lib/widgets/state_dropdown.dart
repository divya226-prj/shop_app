import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';

class StateDropdownfield extends StatefulWidget {
  const StateDropdownfield({
    required this.onchanged,
    required this.items,
    required this.value,
    super.key,
  });
  final void Function(String?)? onchanged;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  @override
  State<StateDropdownfield> createState() => _StateDropdownfieldState();
}

class _StateDropdownfieldState extends State<StateDropdownfield> {
  String? selectedStateKey = 'Gujarat';
  String? selectedCountryKey = 'India';
  String? selectedCityKey = 'A';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: widget.value ?? selectedCountryKey,
          icon: Icon(Icons.keyboard_arrow_down),
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
          items: widget.items,
          onChanged: widget.onchanged,
        ),
      ],
    );
  }
}
