import 'package:flutter/material.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../models/participant_model.dart';
import '../utils/formatters.dart';
import '../themes/app_spacing.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class ParticipantGrid extends StatelessWidget {
  final List<Participant> participants;
  final Activity selectedActivity;
  final bool isRunning;
  final ValueChanged<int> onRecordTime;
  final Color? activeColor;
  final Color? inactiveColor;
  final BorderRadiusGeometry borderRadius;

  const ParticipantGrid({
    Key? key,
    required this.participants,
    required this.selectedActivity,
    required this.isRunning,
    required this.onRecordTime,
    this.activeColor,
    this.inactiveColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color active = activeColor ?? AppColors.primaryDark;
    final Color inactive = inactiveColor ?? AppColors.primary.withOpacity(0.5);

    return GridView.builder(
      padding: AppSpacing.all8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: participants.length,
      itemBuilder: (ctx, i) {
        final p = participants[i];
        final time = () {
          switch (selectedActivity) {
            case Activity.Swimming:
              return p.swimmingTimer;
            case Activity.Cycling:
              return p.cyclingTimer;
            case Activity.Running:
              return p.runningTimer;
          }
        }();

        return GestureDetector(
          onTap: isRunning ? () => onRecordTime(p.bib) : null,
          child: Container(
            decoration: BoxDecoration(
              color: p.status ? active : inactive,
              borderRadius: borderRadius,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  p.bib.toString().padLeft(2, '0'),
                  style: AppTextStyles.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (time > Duration.zero) ...[
                  AppSpacing.gapH4,
                  Text(
                    formatDuration(time),
                    style: AppTextStyles.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
