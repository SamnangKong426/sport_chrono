import 'package:flutter/material.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../models/participant_model.dart';
import '../utils/formatters.dart';

/// A 2-column grid of participants with their bib & elapsed time.
///
/// You can drop this anywhere, just pass in your VM’s data & callbacks.
class ParticipantGrid extends StatelessWidget {
  final List<Participant> participants;
  final Activity selectedActivity;
  final bool isRunning;
  final ValueChanged<int> onRecordTime;
  final Color activeColor;
  final Color inactiveColor;
  final BorderRadiusGeometry borderRadius;

  const ParticipantGrid({
    Key? key,
    required this.participants,
    required this.selectedActivity,
    required this.isRunning,
    required this.onRecordTime,
    this.activeColor = const Color(0xFF3D5AA8),
    this.inactiveColor = const Color(0xFFABB9E8),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
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
              color: p.status ? activeColor : inactiveColor,
              borderRadius: borderRadius,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  p.bib.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (time > Duration.zero) ...[
                  const SizedBox(height: 4),
                  Text(
                    formatDuration(time),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
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