import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final TextAlign? textAlign;

  const BoldText({
    super.key,
    required this.text,
    this.size = 20,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.white,
      ),
    );
  }
}