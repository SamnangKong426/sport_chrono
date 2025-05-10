import 'package:flutter/material.dart';
import '../themes/app_spacing.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../themes/app_colors.dart';

class ActivityButton extends StatelessWidget {
  final Activity activity;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityButton({
    Key? key,
    required this.activity,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define activity-specific colors
    const Map<Activity, Color> activityColors = {
      Activity.Swimming: AppColors.primaryDark,
      Activity.Cycling: AppColors.primaryDark,
      Activity.Running: AppColors.primaryDark,
    };

    const Map<Activity, IconData> activityIcons = {
      Activity.Swimming: Icons.pool,
      Activity.Cycling: Icons.directions_bike,
      Activity.Running: Icons.directions_run,
    };

    final Color color = activityColors[activity]!;
    final IconData icon = activityIcons[activity]!;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? color : Colors.grey,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? color : Colors.grey,
            size: 18,
          ),
          AppSpacing.gapW4,
          Text(
            activity.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? color : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
