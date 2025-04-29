import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/participant_model.dart';

class ParticipantService {
  final CollectionReference _participants = FirebaseFirestore.instance
      .collection('participants');

  Future<void> addParticipant(Participant participant) async {
    await _participants.add(participant.toJson());
  }

  Future<void> removeParticipant(int bib) async {
    await _participants.where('bib', isEqualTo: bib).get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<void> removeAllParticipants() async {
    final participantsSnapshot = await _participants.get();
    for (var doc in participantsSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
