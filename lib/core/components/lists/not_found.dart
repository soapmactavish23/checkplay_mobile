import 'package:flutter/material.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final colorDefault = Theme.of(context).primaryColor.withAlpha(400);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            ImageConstants.logo,
            width: 200,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.block,
              color: colorDefault,
            ),
            Text(
              'NENHUM REGISTRO ENCONTRADO',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorDefault,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
