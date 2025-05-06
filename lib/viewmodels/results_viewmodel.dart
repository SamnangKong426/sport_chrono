import 'package:flutter/foundation.dart';
import 'package:sport_chrono/models/participant_model.dart';

class ResultsViewModel extends ChangeNotifier {
  final List<Participant> _all = [
    Participant(bib: 1, name: 'John Doe', status: true),
    Participant(bib: 2, name: 'Jane Smith', status: false),
  ];
  List<Participant> _filtered = [];

  ResultsViewModel() {
    _filtered = List.from(_all);
  }

  List<Participant> get results => _filtered;

  void search(String query) {
    if (query.isEmpty) {
      _filtered = List.from(_all);
    } else {
      final bib = int.tryParse(query);
      _filtered =
          _all.where((p) {
            return bib != null
                ? p.bib == bib
                : p.name.toLowerCase().contains(query.toLowerCase());
          }).toList();
    }
    notifyListeners();
  }
}
