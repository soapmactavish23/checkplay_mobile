// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextSpanTile extends StatelessWidget {
  String label;
  String value;
  TextSpanTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 14),
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            TextSpan(
              text: value,
            ),
          ],
        ),
      ),
    );
  }
}
