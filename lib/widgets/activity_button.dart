import 'package:flutter/material.dart';
import '../viewmodels/timer_viewmodel.dart';

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
    // map each activity to its accent color
    const _colors = {
      Activity.Swimming: Color(0xFF1A2C70),
      Activity.Cycling: Color(0xFF3D5AA8),
      Activity.Running: Color(0xFFABB9E8),
    };
    const _icons = {
      Activity.Swimming: Icons.pool,
      Activity.Cycling: Icons.directions_bike,
      Activity.Running: Icons.directions_run,
    };
    final color = _colors[activity]!;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            // use accent color only when selected; else grey
            color: isSelected ? color : Colors.grey,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _icons[activity],
            color: isSelected ? color : Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            activity.name,
            style: TextStyle(
              color: isSelected ? color : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
