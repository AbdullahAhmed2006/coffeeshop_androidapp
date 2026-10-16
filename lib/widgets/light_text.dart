import 'package:flutter/material.dart';

class LightText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;

  const LightText({
    super.key,
    required this.text,
    this.size = 14,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        color: color ?? Colors.white70,
      ),
    );
  }
}