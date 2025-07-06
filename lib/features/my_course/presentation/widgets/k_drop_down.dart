import 'package:flutter/material.dart';

class KDropDown extends StatelessWidget {
  const KDropDown({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.labelText,
  });
  final List<String> items;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: labelText),
      value: selectedValue,
      items:
          items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      onChanged: onChanged,
    );
  }
}
