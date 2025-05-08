import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/viewmodels/timer_viewmodel.dart';

class ParticipantTable extends StatelessWidget {
  const ParticipantTable({
    super.key,
    required this.participants,
    required this.activity,
  });

  final List<Participant> participants;
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    Duration _timerFor(Participant p) {
      switch (activity) {
        case Activity.Swimming:
          return p.swimmingTimer;
        case Activity.Cycling:
          return p.cyclingTimer;
        case Activity.Running:
          return p.runningTimer;
      }
    }

    Widget _cell(String text, {bool highlighted = false}) {
      final color =
          highlighted
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: TextStyle(color: color, fontSize: 16)),
      );
    }

    final header = TableRow(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(128),
        borderRadius: BorderRadius.circular(8),
      ),
      children: [
        _cell('BIB', highlighted: true),
        _cell('Name', highlighted: true),
        _cell('Timer', highlighted: true),
        _cell('Status', highlighted: true),
      ],
    );

    final spacer = const TableRow(
      children: [SizedBox(height: 8), SizedBox(), SizedBox(), SizedBox()],
    );

    final rows =
        participants.expand<TableRow>((p) {
          final t = _timerFor(p).toString().split('.').first;
          final active = p.status;
          final bg =
              p.status ? Theme.of(context).colorScheme.primary : Colors.white;
          return [
            TableRow(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
              ),
              children: [
                _cell(p.bib.toString(), highlighted: p.status),
                _cell(p.name, highlighted: p.status),
                _cell(t, highlighted: active),
                _cell(active ? 'Untrack' : 'Track', highlighted: active),
              ],
            ),
            spacer,
          ];
        }).toList();

    return Flexible(
      child: SingleChildScrollView(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FixedColumnWidth(60),
            1: FlexColumnWidth(),
            2: FixedColumnWidth(80),
            3: FixedColumnWidth(80),
          },
          children: [header, spacer, ...rows],
        ),
      ),
    );
  }
}
