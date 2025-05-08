import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';
import 'package:sport_chrono/services/timer_service.dart';
import 'package:sport_chrono/viewmodels/timer_viewmodel.dart'; // for Activity

class RaceViewModel extends ChangeNotifier {
  List<Participant> _all = [];
  List<Participant> participants = [];

  Activity selectedActivity = Activity.Swimming;

  RaceViewModel() {
    TimerService.instance.addListener(notifyListeners);
    _loadParticipants();
  }

  Duration get elapsed => TimerService.instance.elapsed;

  Future<void> refresh() => _loadParticipants();

  Future<void> _loadParticipants() async {
    _all = await ParticipantService.getParticipants();
    // sort by bib ascending
    _all.sort((a, b) => a.bib.compareTo(b.bib));
    participants = List.from(_all);
    notifyListeners();
  }

  void selectActivity(Activity a) {
    selectedActivity = a;
    debugPrint('Selected activity: $selectedActivity');
    
    notifyListeners();
  }

  void filterByBib(String query) {
    if (query.isEmpty) {
      participants = List.from(_all);
    } else {
      final q = query.toLowerCase();
      participants =
          _all
              .where(
                (p) =>
                    p.bib.toString().contains(q) ||
                    p.name.toLowerCase().contains(q),
              )
              .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    TimerService.instance.removeListener(notifyListeners);
    super.dispose();
  }
}
