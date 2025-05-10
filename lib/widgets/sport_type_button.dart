import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';
import '../themes/app_text_styles.dart';

class SportTypeButton extends StatefulWidget {
  const SportTypeButton({
    super.key,
    required this.sportType,
    required this.iconData,
    required this.isSelected,
    required this.onTap,
  });

  final String sportType;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<SportTypeButton> createState() => _SportTypeButtonState();
}

class _SportTypeButtonState extends State<SportTypeButton> {
  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.primaryDark;
    final Color inactiveColor = AppColors.primary;

    final Color borderColor = widget.isSelected ? activeColor : inactiveColor;
    final Color textColor = widget.isSelected ? activeColor : inactiveColor;

    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
        padding: AppSpacing.horizontalPadding,
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.iconData, color: textColor),
          AppSpacing.gapW8,
          Text(
            widget.sportType,
            style: AppTextStyles.textTheme.bodyMedium?.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
