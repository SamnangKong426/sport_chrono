import 'package:sport_chrono/models/participant_model.dart';

class Race {
  final String sportType;
  final List<Participant> participants;

  Race({required this.participants, required this.sportType});
}