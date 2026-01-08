import 'package:flutter/material.dart';

class OutlinedCustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;

  final EdgeInsets padding;
  final double fontSize;
  final Color btnTextColor;
  final Widget? icon;
  final MainAxisAlignment mainAxisAlignment;
  const OutlinedCustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.padding = const EdgeInsets.fromLTRB(32, 16, 32, 16),
    this.fontSize = 18,
    this.btnTextColor = Colors.black,
    this.icon,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          side: WidgetStateProperty.resolveWith<BorderSide>(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return BorderSide(color: btnTextColor);
              }
              return BorderSide(color: btnTextColor, width: 1.5);
            },
          ),
          foregroundColor: WidgetStateProperty.all(btnTextColor),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              icon ?? Container(),
              Text(
                label,
                style: TextStyle(
                  color: btnTextColor,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
