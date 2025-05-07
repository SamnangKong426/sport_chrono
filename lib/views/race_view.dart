import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sport_chrono/widgets/timer_display.dart';
import 'package:sport_chrono/widgets/activity_selector.dart';
import 'package:sport_chrono/widgets/bib_search_bar.dart';
import 'package:sport_chrono/widgets/participant_table.dart';

import '../viewmodels/race_viewmodel.dart';
import '../utils/formatters.dart';

class RaceView extends StatelessWidget {
  const RaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RaceViewModel>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TimerDisplay(text: formatDuration(vm.elapsed)),

            ActivitySelector(
              selectedActivity: vm.selectedActivity,
              onActivitySelected: vm.selectActivity,
            ),


            // 3) bib filter
            BIBSearchBar(onChanged: vm.filterByBib),

            const SizedBox(height: 20),

            // 4) participants table
            Expanded(
              child:
                  vm.participants.isEmpty
                      ? const Center(child: Text('No participants found.'))
                      : ParticipantTable(participants: vm.participants),
            ),
          ],
        ),
      ),
    );
  }
}
