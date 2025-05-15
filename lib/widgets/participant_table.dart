import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/viewmodels/timer_viewmodel.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';
import '../themes/app_text_styles.dart';

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
      final color = highlighted ? Colors.white : AppColors.primaryDark;
      return Padding(
        padding: AppSpacing.all8,
        child: Text(
          text,
          style: AppTextStyles.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }

    final header = TableRow(
      decoration: BoxDecoration(
        color: AppColors.primaryDark.withOpacity(0.8),
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

    final rows = participants.expand<TableRow>((p) {
      final t = _timerFor(p).toString().split('.').first;
      final active = _timerFor(p) == Duration.zero;
      final bg = active ? AppColors.primaryDark : AppColors.primary.withOpacity(0.2);
      return [
        TableRow(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          children: [
            _cell(p.bib.toString(), highlighted: active),
            _cell(p.name, highlighted: active),
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
