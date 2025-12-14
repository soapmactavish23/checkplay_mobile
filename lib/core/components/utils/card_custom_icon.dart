// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardCustomIcon extends StatelessWidget {
  String title;
  Widget? subtitle;
  Function()? onTap;
  Function()? onLongPress;
  Color? colorTitle;
  Widget? icon;
  Widget? trailing;
  CardCustomIcon({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.onLongPress,
    this.colorTitle,
    this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ListTile(
            leading: icon,
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: colorTitle ?? Theme.of(context).primaryColor,
              ),
            ),
            trailing: trailing,
            subtitle: subtitle,
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        ),
      ),
    );
  }
}
