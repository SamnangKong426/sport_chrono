import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/widgets/page_selector.dart';
import 'package:sport_chrono/widgets/timer_display.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../widgets/activity_selector.dart';
import '../widgets/participant_grid.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              TimerDisplay(text: vm.timerText),
              ActivitySelector(
                selectedActivity: vm.selectedActivity,
                onActivitySelected: vm.selectActivity,
              ),
              PageSelector(
                labels: vm.pageLabels,
                currentIndex: vm.pageIndex,
                onPrevious: vm.previousPage,
                onNext: vm.nextPage,
                onPageSelected: vm.goToPage,
              ),
              Expanded(
                child: ParticipantGrid(
                  participants: vm.currentParticipants,
                  selectedActivity: vm.selectedActivity,
                  isRunning: vm.isRunning,
                  onRecordTime: vm.recordTime,
                ),
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!vm.isRunning)
                FloatingActionButton(
                  onPressed: vm.start,
                  child: const Icon(Icons.play_arrow),
                )
              else
                FloatingActionButton(
                  onPressed: vm.pause,
                  child: const Icon(Icons.pause),
                ),
              const SizedBox(width: 12),
              FloatingActionButton(
                onPressed: vm.reset,
                child: const Icon(Icons.replay),
              ),
            ],
          ),
        );
      },
    );
  }
}
