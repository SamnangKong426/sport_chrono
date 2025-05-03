import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/participant_model.dart';

class ParticipantService {
  // static Firestore collection
  static final CollectionReference _participants = FirebaseFirestore.instance
      .collection('participants');

  static Future<List<Participant>> getParticipants() async {
    final snapshot = await _participants.get();
    return snapshot.docs
        .map((doc) => Participant.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<void> addParticipant(Participant participant) async {
    await _participants.add(participant.toJson());
  }

  static Future<void> removeParticipant(int bib) async {
    final snapshot = await _participants.where('bib', isEqualTo: bib).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> removeAllParticipants() async {
    final snapshot = await _participants.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
