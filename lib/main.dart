import 'package:flutter/material.dart';
import 'package:sport_chrono/themes/app_theme.dart';
import 'package:sport_chrono/views/race_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sport Chrono',
      theme: AppTheme.light,
      home: const RaceView(),
    ),
  );
}
