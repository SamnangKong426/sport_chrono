import '../models/participant_model.dart';

class ParticipantService {
  final List<Participant> _participants = [
    Participant(
      bib: '001',
      name: 'John Doe',
      timer: Duration.zero,
      status: false,
    ),
    Participant(
      bib: '002',
      name: 'Jane Smith',
      timer: Duration.zero,
      status: false,
    ),
    Participant(
      bib: '003',
      name: 'Alice Johnson',
      timer: Duration.zero,
      status: false,
    ),
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
