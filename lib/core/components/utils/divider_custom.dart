import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.withAlpha(90),
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.withAlpha(90),
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
