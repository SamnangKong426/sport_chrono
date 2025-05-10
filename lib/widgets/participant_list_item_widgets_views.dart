import 'package:flutter/material.dart';
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
      margin: AppSpacing.bottom16,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 30,
          child: Text(
            participant.bib.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        title: Text(
          participant.name,
          style: Theme.of(context).textTheme.bodyLarge,
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
