import 'package:flutter/material.dart';

class TimerCounter extends StatefulWidget {
  const TimerCounter({super.key, required this.timer});
  final Duration timer;

  @override
  State<TimerCounter> createState() => _TimerCounterState();
}

class _TimerCounterState extends State<TimerCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "${widget.timer.inHours.toString().padLeft(2, '0')}:${(widget.timer.inMinutes % 60).toString().padLeft(2, '0')}:${(widget.timer.inSeconds % 60).toString().padLeft(2, '0')}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
