import 'package:flutter/material.dart';

class AppSpacing {
  // Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: 12.0);
  static const EdgeInsets all8 = EdgeInsets.all(8.0);
  static const EdgeInsets all16 = EdgeInsets.all(16.0);
  static const EdgeInsets all24 = EdgeInsets.all(24.0);

  // Margin
  static const EdgeInsets top8 = EdgeInsets.only(top: 8.0);
  static const EdgeInsets bottom16 = EdgeInsets.only(bottom: 16.0);
  static const EdgeInsets horizontal24 = EdgeInsets.symmetric(horizontal: 24.0);

  // Spacing between widgets (SizedBox)
  static const SizedBox gapH4 = SizedBox(height: 4.0);
  static const SizedBox gapW4 = SizedBox(width: 4.0);
  static const SizedBox gapH8 = SizedBox(height: 8.0);
  static const SizedBox gapW8 = SizedBox(width: 8.0);
  static const SizedBox gapH16 = SizedBox(height: 16.0);
  static const SizedBox gapW16 = SizedBox(width: 16.0);
  static const SizedBox gapH24 = SizedBox(height: 24.0);
  static const SizedBox gapW24 = SizedBox(width: 24.0);
}
