import 'package:flutter/material.dart';
import '../models/participant_model.dart';

class ParticipantListItem extends StatelessWidget {
  final Participant participant;
  final VoidCallback onDelete;

  const ParticipantListItem({
    Key? key,
    required this.participant,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 30,
          child: Text(
            participant.bib,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(participant.name),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
