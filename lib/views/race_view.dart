import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/widgets/activity_selector.dart';
import 'package:sport_chrono/widgets/bib_search_bar.dart';
import 'package:sport_chrono/widgets/timer_display.dart';
import 'package:sport_chrono/widgets/participant_table.dart';
import '../viewmodels/race_viewmodel.dart';
import '../utils/formatters.dart';

class RaceView extends StatefulWidget {
  const RaceView({Key? key}) : super(key: key);

  @override
  State<RaceView> createState() => _RaceViewState();
}

class _RaceViewState extends State<RaceView> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void showFinishNotification(String bibNumber) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text('Synced participant #$bibNumber to Firestore'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RaceViewModel>();

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            TimerDisplay(text: formatDuration(vm.elapsed)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ActivitySelector(
                selectedActivity: vm.selectedActivity,
                onActivitySelected: vm.selectActivity,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BIBSearchBar(onChanged: vm.filterByBib),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:
                    vm.participants.isEmpty
                        ? const Center(child: Text('No participants found.'))
                        : ParticipantTable(
                          participants: vm.participants,
                          activity: vm.selectedActivity, // ← pass it here
                        ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
