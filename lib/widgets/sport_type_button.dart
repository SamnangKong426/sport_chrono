import 'package:flutter/material.dart';

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
    final primary = Theme.of(context).colorScheme.primary;
    final selected = Theme.of(context).colorScheme.secondary;
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: widget.isSelected ? selected : primary,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(widget.iconData, color: widget.isSelected ? selected : primary),
          const SizedBox(width: 8.0),
          Text(
            widget.sportType,
            style: TextStyle(color: widget.isSelected ? selected : primary),
          ),
        ],
      ),
    );
  }
}
