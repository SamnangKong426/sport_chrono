import 'package:flutter/material.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';

class ParticipantViewModel extends ChangeNotifier {
  final TextEditingController bibController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<bool> addParticipant() async {
    if (bibController.text.isNotEmpty && nameController.text.isNotEmpty) {
      final bib = int.tryParse(bibController.text);
      if (bib == null) return false;
      
      // check existing
      final existing = await ParticipantService.getParticipants();
      if (existing.any((p) => p.bib == bib)) {
        return false;
      }
      // add new
      await ParticipantService.addParticipant(
        Participant(bib: bib, name: nameController.text, status: true),
      );
      bibController.clear();
      nameController.clear();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<List<Participant>> getParticipants() async {
    debugPrint("Fetching participants");
    final participants = await ParticipantService.getParticipants();
    debugPrint("Number of participants: ${participants.length}");
    return participants;
  }

  Future<void> deleteParticipant(int index) async {
    await ParticipantService.removeParticipant(index);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await ParticipantService.removeAllParticipants();
    notifyListeners();
  }

  Future<void> refresh() => getParticipants();

  @override
  void dispose() {
    bibController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
