import 'package:flutter/material.dart';

typedef PageChanged = void Function(int);

class PageSelector extends StatelessWidget {
  final List<String> labels;
  final int currentIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final PageChanged onPageSelected;

  /// Colors for inactive/active buttons
  final Color inactiveColor;
  final Color activeColor;

  const PageSelector({
    Key? key,
    required this.labels,
    required this.currentIndex,
    required this.onPrevious,
    required this.onNext,
    required this.onPageSelected,
    this.inactiveColor = const Color(0xFFABB9E8),
    this.activeColor = const Color(0xFF3D5AA8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Prev
          Expanded(
            child: GestureDetector(
              onTap: onPrevious,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: inactiveColor,
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
            final isActive = idx == currentIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onPageSelected(idx),
                child: Container(
                  height: 40,
                  color: isActive ? activeColor : inactiveColor,
                  alignment: Alignment.center,
                  child: Text(
                    lbl,
                    style: const TextStyle(
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
                decoration: const BoxDecoration(
                  color: Color(0xFFABB9E8),
                  borderRadius: BorderRadius.horizontal(
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
