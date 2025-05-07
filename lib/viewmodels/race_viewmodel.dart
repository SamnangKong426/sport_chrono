import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/models/race_model.dart';
import 'package:sport_chrono/services/participant_service.dart';
import 'package:sport_chrono/viewmodels/timer_viewmodel.dart';
import '../services/timer_service.dart';

class RaceViewModel extends ChangeNotifier {
  Race _currentRace = Race(sportType: 'Swimming', participants: []);

  List<Participant> _allParticipants = [];

  Activity _selectedActivity = Activity.Swimming;

  Activity get selectedActivity => _selectedActivity;

  List<Participant> get participants => _currentRace.participants;
  String get selectedSport => _currentRace.sportType;

  RaceViewModel() {
    TimerService.instance.addListener(notifyListeners);
    _loadParticipants();
  }

  Duration get elapsed => TimerService.instance.elapsed;
  bool get isRunning => TimerService.instance.running;

  void startTimer() => TimerService.instance.start();
  void stopTimer() => TimerService.instance.pause();
  void resetTimer() => TimerService.instance.reset();

  Future<void> _loadParticipants() async {
    _allParticipants = await ParticipantService.getParticipants();
    _allParticipants.sort((a, b) => a.bib.compareTo(b.bib));
    _currentRace = Race(
      sportType: _currentRace.sportType,
      participants: List.from(_allParticipants),
    );
    notifyListeners();
  }

  void selectSport(String sport) {
    _currentRace = Race(
      sportType: sport,
      participants: List.from(_allParticipants),
    );
    notifyListeners();
  }

  void selectActivity(Activity activity) {
    _selectedActivity = activity;

    // 1) only keep participants who actually have a non-zero time for this activity
    final filtered =
        _allParticipants.where((p) {
          switch (activity) {
            case Activity.Swimming:
              return p.swimmingTimer > Duration.zero;
            case Activity.Cycling:
              return p.cyclingTimer > Duration.zero;
            case Activity.Running:
              return p.runningTimer > Duration.zero;
          }
        }).toList();

    // 2) sort by that same activity’s time
    filtered.sort((a, b) {
      Duration aTime, bTime;
      switch (activity) {
        case Activity.Swimming:
          aTime = a.swimmingTimer;
          bTime = b.swimmingTimer;
          break;
        case Activity.Cycling:
          aTime = a.cyclingTimer;
          bTime = b.cyclingTimer;
          break;
        case Activity.Running:
          aTime = a.runningTimer;
          bTime = b.runningTimer;
          break;
      }
      return aTime.compareTo(bTime);
    });

    // 3) replace your Race model so the view rebuilds
    _currentRace = Race(sportType: activity.name, participants: filtered);

    notifyListeners();
  }

  void filterByBib(String query) {
    final filtered =
        query.isEmpty
            ? List<Participant>.from(_allParticipants)
            : _allParticipants
                .where((p) => p.bib.toString().contains(query))
                .toList();

    _currentRace = Race(
      sportType: _currentRace.sportType,
      participants: filtered.cast<Participant>(),
    );
    notifyListeners();
  }

  Future<void> refresh() => _loadParticipants();

  @override
  void dispose() {
    TimerService.instance.removeListener(notifyListeners);
    super.dispose();
  }
}
