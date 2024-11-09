import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    this.onPressed,
    required this.style,
    this.padding,
  });

  final double height;
  final double width;
  final String title;
  final VoidCallback? onPressed;
  final TextStyle style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D2C83).withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 15,
            spreadRadius: 0,
          ),
        ],
      ),
      child: FilledButton(
        onPressed: () {
          onPressed?.call();
        },
        style: FilledButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: padding),
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}
