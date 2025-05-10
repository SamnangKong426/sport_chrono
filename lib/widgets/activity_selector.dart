import 'package:flutter/material.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../themes/app_spacing.dart';
import 'activity_button.dart';

class ActivitySelector extends StatelessWidget {
  final Activity selectedActivity;
  final ValueChanged<Activity> onActivitySelected;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const ActivitySelector({
    Key? key,
    required this.selectedActivity,
    required this.onActivitySelected,
    this.padding = AppSpacing.all8,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: Activity.values.map((act) {
          return ActivityButton(
            activity: act,
            isSelected: act == selectedActivity,
            onTap: () => onActivitySelected(act),
          );
        }).toList(),
      ),
    );
  }
}
