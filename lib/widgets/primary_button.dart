import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;

  /// OPTIONAL BORDER
  final bool withBorder;            // border enable/disable
  final double borderWidth;         // border thickness
  final Color borderColor;          // border color

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.height = 52,
    this.borderRadius = 16,

    /// Border defaults
    this.withBorder = false,
    this.borderWidth = 1.2,
    this.borderColor = const Color(0xFFD2D2D2), // #D2D2D2
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: withBorder
                ? BorderSide(
              color: borderColor,
              width: borderWidth,
            )
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
