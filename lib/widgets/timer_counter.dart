import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../themes/app_spacing.dart';

class TimerCounter extends StatefulWidget {
  const TimerCounter({super.key, required this.timer});
  final Duration timer;

  @override
  State<TimerCounter> createState() => _TimerCounterState();
}

class _TimerCounterState extends State<TimerCounter> {
  @override
  Widget build(BuildContext context) {
    final formatted = "${widget.timer.inHours.toString().padLeft(2, '0')}:"
        "${(widget.timer.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(widget.timer.inSeconds % 60).toString().padLeft(2, '0')}";

    return Container(
      width: double.infinity,
      padding: AppSpacing.all16,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          formatted,
          style: AppTextStyles.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
