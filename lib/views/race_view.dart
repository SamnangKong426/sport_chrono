import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/viewmodels/race_viewmodel.dart';
import 'package:sport_chrono/widgets/bib_search_bar.dart';
import 'package:sport_chrono/widgets/participant_table.dart';
import 'package:sport_chrono/widgets/sport_type_button.dart';
import 'package:sport_chrono/widgets/timer_counter.dart';

class RaceView extends StatelessWidget {
  const RaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RaceViewModel>();
    final participants = vm.participants;
    final timer = vm.elapsed;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Race',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: vm.toggleTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: vm.isRunning ? Colors.red : Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      vm.isRunning ? 'Stop' : 'Start',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TimerCounter(timer: timer),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SportTypeButton(
                  sportType: 'Swimming',
                  iconData: Icons.pool,
                  isSelected: vm.selectedSport == 'Swimming',
                  onTap: () => vm.selectSport('Swimming'),
                ),
                const Spacer(),
                SportTypeButton(
                  sportType: 'Cycling',
                  iconData: Icons.directions_bike,
                  isSelected: vm.selectedSport == 'Cycling',
                  onTap: () => vm.selectSport('Cycling'),
                ),
                const Spacer(),
                SportTypeButton(
                  sportType: 'Running',
                  iconData: Icons.run_circle_outlined,
                  isSelected: vm.selectedSport == 'Running',
                  onTap: () => vm.selectSport('Running'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // wire your search bar into the VM
            BIBSearchBar(onChanged: vm.filterByBib),
            const SizedBox(height: 20),


            // status guide
            Row(
              children: [
              Row(
                children: [
                Icon(
                  Icons.circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Untrack',
                  style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                ],
              ),
              const SizedBox(width: 20.0),
              Row(
                children: [
                Icon(
                  Icons.circle,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 16,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Track',
                  style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                ],
              ),
              ],
            ),
            const SizedBox(height: 20),
            ParticipantTable(participants: participants),
          ],
        ),
      ),
    );
  }
}
