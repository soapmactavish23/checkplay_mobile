import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

DropDownDecoratorProps getStyle({required String label, required String hintText}) {
  return DropDownDecoratorProps(
    dropdownSearchDecoration: InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      hintText: hintText,
      label: Text(label),
      prefixIcon: const Padding(
        padding: EdgeInsets.all(16),
        child: Icon(Icons.copy_all),
      ),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
