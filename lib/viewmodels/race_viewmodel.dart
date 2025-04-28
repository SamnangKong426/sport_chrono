import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/models/race_model.dart';

class RaceViewModel extends ChangeNotifier {
  // use Race model to hold sport type + participants
  Race _currentRace = Race(sportType: 'Swimming', participants: []);

  // backing store for all participants (unfiltered)
  final List<Participant> _allParticipants = [];

  // expose getters that read from the Race model
  List<Participant> get participants => _currentRace.participants;
  String get selectedSport => _currentRace.sportType;

  // global race timer
  Timer? _timer;
  Duration elapsed = Duration.zero;
  bool isRunning = false;

  RaceViewModel() {
    _loadParticipants();
  }

  void _loadParticipants() {
    // TODO: replace with real data source
    _allParticipants.addAll([
      Participant(bib: '1', name: 'Alice', timer: Duration.zero, status: false),
      Participant(bib: '2', name: 'Bob', timer: Duration.zero, status: true),
      Participant(bib: '3', name: 'Carl', timer: Duration.zero, status: false),
      Participant(bib: '4', name: 'Diana', timer: Duration.zero, status: true),
    ]);
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
            : _allParticipants.where((p) => p.bib.contains(query)).toList();

    _currentRace = Race(
      sportType: _currentRace.sportType,
      participants: filtered.cast<Participant>(),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
