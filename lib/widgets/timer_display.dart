import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;

  const TimerDisplay({
    Key? key,
    required this.text,
    this.backgroundColor = const Color(0xFF1A2C70),
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.padding = const EdgeInsets.symmetric(vertical: 25),
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 42,
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Text(text, style: textStyle),
    );
  }
}