import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double fontSize;
  final Color btnTextColor;
  final Widget? icon;
  final MainAxisAlignment mainAxisAlignment;

  const ButtomCustom({
    Key? key,
    required this.label,
    this.onPressed,
    this.width,
    this.backgroundColor,
    this.padding = const EdgeInsets.fromLTRB(32, 16, 32, 16),
    this.fontSize = 18,
    this.btnTextColor = Colors.white,
    this.icon,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor == null
                ? Theme.of(context).primaryColor
                : backgroundColor!,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
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
