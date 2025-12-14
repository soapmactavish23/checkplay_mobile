import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CardCustomGrid extends StatelessWidget {
  final void Function()? onTap;
  final String url;
  final void Function()? onLongPress;
  final String title;
  const CardCustomGrid(
      {super.key, this.onTap, this.onLongPress, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
