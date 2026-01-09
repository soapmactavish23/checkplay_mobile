// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:checkplay_mobile/core/components/forms/dropdown_search.dart';

class DropdownSearchCustom extends StatelessWidget {
  List<dynamic> items;
  dynamic selectedItem;
  String? labelTextSearch;
  String? hintTextSearch;
  String? Function(dynamic)? validator;
  String Function(dynamic)? itemAsString;
  void Function(dynamic)? onChanged;
  void Function(dynamic)? onSaved;
  String label;
  String hintText;

  DropdownSearchCustom({
    super.key,
    required this.items,
    required this.selectedItem,
    this.labelTextSearch = 'Pesquisar',
    this.hintTextSearch = 'Digite a busca',
    this.validator,
    this.itemAsString,
    this.onChanged,
    this.onSaved,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      validator: validator,
      popupProps: PopupProps.dialog(
        fit: FlexFit.loose,
        showSearchBox: true,
        dialogProps: DialogProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            labelText: labelTextSearch,
            hintText: hintTextSearch,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
          ),
        ),
      ),
      items: items,
      itemAsString: itemAsString,
      selectedItem: selectedItem,
      onChanged: onChanged,
      onSaved: onSaved,
      dropdownDecoratorProps: getStyle(
        label: label,
        hintText: hintText,
      ),
    );
  }
}
