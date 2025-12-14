import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustom extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? hintText;
  final String? label;
  final Widget? icon;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final Widget? suffixIcon;
  final int? maxLength;
  final FocusNode? focusNode;

  const InputCustom({
    super.key,
    required this.controller,
    this.textInputType,
    this.validator,
    this.onSaved,
    this.hintText,
    this.label = "",
    this.icon,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLines = 1,
    this.onChanged,
    this.suffixIcon,
    this.maxLength,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: textInputType,
      validator: validator,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      autofocus: false,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text("$label"),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16),
          child: icon,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
