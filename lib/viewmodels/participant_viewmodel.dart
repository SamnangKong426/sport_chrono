import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';
// import '../models/participant.dart';

class ParticipantViewModel extends ChangeNotifier {
  final TextEditingController bibController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  // List<Participant> get participants => ParticipantService.participants;

  void addParticipant() {
    if (bibController.text.isNotEmpty && nameController.text.isNotEmpty) {
      ParticipantService.addParticipant(
        Participant(
          bib: int.parse(bibController.text),
          name: nameController.text,
          status: false,
        ),
      );
      bibController.clear();
      nameController.clear();
      notifyListeners();
    }
  }

  void deleteParticipant(int index) {
    ParticipantService.removeParticipant(index);
    notifyListeners();
  }

  void deleteAll() {
    ParticipantService.removeAllParticipants();
    notifyListeners();
  }

  void navigateToNextScreen() {
    // Implementation for navigation to the next screen
  }

  @override
  void dispose() {
    bibController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
