import '../models/participant_models.dart';

class ParticipantService {
  List<Participant> _participants = [
    Participant(bib: '01', name: 'Samnang'),
    Participant(bib: '10', name: 'Yaya'),
    Participant(bib: '168', name: 'Tong Tong'),
    Participant(bib: '111', name: 'Samnang'),
    Participant(bib: '221', name: 'Samnang'),
  ];

  List<Participant> get participants => _participants;

  void addParticipant(Participant participant) {
    _participants.add(participant);
  }

  void removeParticipant(int index) {
    if (index >= 0 && index < _participants.length) {
      _participants.removeAt(index);
    }
  }

  void removeAllParticipants() {
    _participants.clear();
  }

  // For future implementation: store participants in local storage or remote database
  Future<void> saveParticipants() async {
    // Implementation for saving participants
  }

  Future<void> loadParticipants() async {
    // Implementation for loading participants
  }
}
