// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardCustom extends StatelessWidget {
  String title;
  Widget? subtitle;
  Function()? onTap;
  Function()? onLongPress;
  Color? colorTitle;

  CardCustom({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.onLongPress,
    this.colorTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: colorTitle ?? Theme.of(context).primaryColor,
            ),
          ),
          subtitle: subtitle,
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
