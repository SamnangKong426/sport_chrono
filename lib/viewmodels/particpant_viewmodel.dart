import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';

class ParticipantViewModel extends ChangeNotifier {
  final ParticipantService _participantService = ParticipantService();
  final TextEditingController bibController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  List<Participant> get participants => _participantService.participants;

  void addParticipant() {
    if (bibController.text.isNotEmpty && nameController.text.isNotEmpty) {
      _participantService.addParticipant(
        Participant(
          bib: bibController.text,
          name: nameController.text,
          timer: Duration.zero,
          status: false,
        ),
      );
      bibController.clear();
      nameController.clear();
      notifyListeners();
    }
  }

  void deleteParticipant(int index) {
    _participantService.removeParticipant(index);
    notifyListeners();
  }

  void deleteAll() {
    _participantService.removeAllParticipants();
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
