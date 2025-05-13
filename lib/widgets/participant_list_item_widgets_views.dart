import 'package:flutter/material.dart';
import 'package:sport_chrono/themes/app_text_styles.dart';
import '../models/participant_model.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';

class ParticipantListItem extends StatelessWidget {
  final Participant participant;
  final VoidCallback onDelete;

  const ParticipantListItem({
    super.key,
    required this.participant,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSpacing.bottom8,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: SizedBox(
          width: 30,
          child: Text(
            participant.bib.toString(),
            style: AppTextStyles.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark.withOpacity(0.8),
            ),
          ),
        ),
        title: Text(
          participant.name,
          style: AppTextStyles.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark.withOpacity(0.8),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: AppColors.error),
          onPressed: onDelete,
        ),
        contentPadding: AppSpacing.horizontalPadding,
      ),
    );
  }
}
