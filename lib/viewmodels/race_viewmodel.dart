import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/models/race_model.dart';
import 'package:sport_chrono/services/participant_service.dart';

class RaceViewModel extends ChangeNotifier {
  // use Race model to hold sport type + participants
  Race _currentRace = Race(sportType: 'Swimming', participants: []);

  // backing store for all participants (unfiltered)
  List<Participant> _allParticipants = [];

  // expose getters that read from the Race model
  List<Participant> get participants => _currentRace.participants;
  String get selectedSport => _currentRace.sportType;

  // Service

  // global race timer
  Timer? _timer;
  Duration elapsed = Duration.zero;
  bool isRunning = false;

  RaceViewModel() {
    _loadParticipants();
  }

  Future<void> _loadParticipants() async {
    _allParticipants = await ParticipantService.getParticipants();
    // initialize Race with loaded participants
    _currentRace = Race(
      sportType: _currentRace.sportType,
      participants: List.from(_allParticipants),
    );
    notifyListeners();
  }

  // change sport on the Race model
  void selectSport(String sport) {
    _currentRace = Race(
      sportType: sport,
      participants: List.from(_allParticipants),
    );
    notifyListeners();
  }

  // timer controls
  void toggleTimer() => isRunning ? stopTimer() : startTimer();

  void startTimer() {
    if (isRunning) return;
    isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsed += const Duration(seconds: 1);
      notifyListeners();
    });
    notifyListeners();
  }

  void stopTimer() {
    if (!isRunning) return;
    _timer?.cancel();
    isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    elapsed = Duration.zero;
    isRunning = false;
    notifyListeners();
  }

  // filter participants by BIB (partial match) via new Race instance
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
    _timer?.cancel();
    super.dispose();
  }
}
