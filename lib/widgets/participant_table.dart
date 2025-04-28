import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';

class ParticipantTable extends StatelessWidget {
  const ParticipantTable({super.key, required this.participants});

  final List<Participant> participants;

  @override
  Widget build(BuildContext context) {
    var tableRow = TableRow(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(128),
        borderRadius: BorderRadius.circular(8.0),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'BIB',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Timer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

    return Table(
      children: [
        tableRow,
        for (var participant in participants) ...[
          TableRow(
            decoration: BoxDecoration(
              color:
                  participant.status
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.bib.toString(),
                  style: TextStyle(
                    color:
                        participant.status
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.name,
                  style: TextStyle(
                    color:
                        participant.status
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.timer.toString().split('.').first,
                  style: TextStyle(
                    color:
                        participant.status
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  participant.status ? 'Track' : 'Untrack',
                  style: TextStyle(
                    color:
                        participant.status
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const TableRow(
            children: [SizedBox(height: 8), SizedBox(), SizedBox(), SizedBox()],
          ),
        ],
      ],
    );
  }
}
