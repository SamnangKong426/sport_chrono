import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';
import '../themes/app_text_styles.dart';

typedef PageChanged = void Function(int);

class PageSelector extends StatelessWidget {
  final List<String> labels;
  final int currentIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final PageChanged onPageSelected;

  /// Colors for inactive/active buttons
  final Color? inactiveColor;
  final Color? activeColor;

  const PageSelector({
    Key? key,
    required this.labels,
    required this.currentIndex,
    required this.onPrevious,
    required this.onNext,
    required this.onPageSelected,
    this.inactiveColor,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color inactive = inactiveColor ?? AppColors.primary.withOpacity(0.4);
    final Color active = activeColor ?? AppColors.primaryDark;

    return Padding(
      padding: AppSpacing.all16,
      child: Row(
        children: [
          // Prev
          Expanded(
            child: GestureDetector(
              onTap: onPrevious,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: inactive,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(8),
                  ),
                ),
                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),
            ),
          ),

          // Page numbers
          ...labels.asMap().entries.map((e) {
            final idx = e.key;
            final lbl = e.value;
            final bool isActive = idx == currentIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onPageSelected(idx),
                child: Container(
                  height: 40,
                  color: isActive ? active : inactive,
                  alignment: Alignment.center,
                  child: Text(
                    lbl,
                    style: AppTextStyles.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),

          // Next
          Expanded(
            child: GestureDetector(
              onTap: onNext,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: inactive,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(8),
                  ),
                ),
                child: const Icon(Icons.chevron_right, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
