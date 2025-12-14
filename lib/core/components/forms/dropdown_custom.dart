import 'package:flutter/material.dart';

class DropdownCustom extends StatelessWidget {
  final String value;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final List<DropdownMenuItem<String>> items;
  final Widget? hint;
  final Icon? icon;
  final Color? hintColor;
  final Color? textColor;
  final Color? dropdownColor;
  final String label;

  const DropdownCustom({
    Key? key,
    required this.value,
    this.onSaved,
    this.onChanged,
    required this.items,
    this.hint,
    this.icon,
    this.hintColor,
    this.textColor = Colors.black,
    this.dropdownColor,
    this.validator,
    this.label = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        label: Text(label),
        contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        filled: true,
        fillColor: const Color.fromRGBO(255, 255, 255, 0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        prefixIcon: icon,
        hintStyle: TextStyle(color: hintColor),
      ),
      value: value,
      hint: hint,
      dropdownColor: dropdownColor,
      onSaved: onSaved,
      style: TextStyle(
        color: textColor,
        fontSize: 16,
      ),
      items: items,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
