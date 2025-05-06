import 'package:flutter/foundation.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';

class ResultsViewModel extends ChangeNotifier {
  List<Participant> _allParticipants = [];
  List<Participant> _filtered = [];

  ResultsViewModel() {
    _loadParticipants();
  }

  Future<void> _loadParticipants() async {
    _allParticipants = await ParticipantService.getParticipants();
    _filtered = List.from(_allParticipants);
    notifyListeners();
  }

  Future<void> refresh() => _loadParticipants();

  List<Participant> get results => _filtered;

  void search(String query) {
    if (query.isEmpty) {
      _filtered = List.from(_allParticipants);
    } else {
      final q = query.toLowerCase();
      _filtered =
          _allParticipants.where((p) {
            return p.bib.toString().contains(q) ||
                p.name.toLowerCase().contains(q);
          }).toList();
    }
    notifyListeners();
  }
}
