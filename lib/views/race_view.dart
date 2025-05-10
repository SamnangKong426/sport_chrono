import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/widgets/activity_selector.dart';
import 'package:sport_chrono/widgets/bib_search_bar.dart';
import 'package:sport_chrono/widgets/timer_display.dart';
import 'package:sport_chrono/widgets/participant_table.dart';
import 'package:sport_chrono/themes/app_spacing.dart';
import 'package:sport_chrono/themes/app_colors.dart';

import '../viewmodels/race_viewmodel.dart';
import '../utils/formatters.dart';

class RaceView extends StatelessWidget {
  const RaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final raceViewModel = context.watch<RaceViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //* Timer Display
              TimerDisplay(text: formatDuration(raceViewModel.elapsed)),

              AppSpacing.gapH8,

              //* Activity Selector
              ActivitySelector(
                selectedActivity: raceViewModel.selectedActivity,
                onActivitySelected: raceViewModel.selectActivity,
              ),

              AppSpacing.gapH8,

              //* Search Bar
              BIBSearchBar(onChanged: raceViewModel.filterByBib),
          
              AppSpacing.gapH16,

              //* Participant Display
              Expanded(
                child: raceViewModel.participants.isEmpty
                    ? Center(
                        child: Text(
                          'No participants found.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      )
                    : ParticipantTable(
                        participants: raceViewModel.participants,
                        activity: raceViewModel.selectedActivity,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
