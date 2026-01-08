import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            ImageConstants.not_found,
            width: 400,
          ),
        ),
      ],
    );
  }
}
