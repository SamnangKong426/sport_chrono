import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class TimerDisplay extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;

  const TimerDisplay({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryDark,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: textStyle ??
            AppTextStyles.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
