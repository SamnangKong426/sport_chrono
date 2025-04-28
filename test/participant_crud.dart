import 'package:flutter_test/flutter_test.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';

void main() {
  group('ParticipantService Tests', () {
    test('Initial participants count should be 3', () {
      ParticipantService participantService = ParticipantService();
      expect(participantService.participants.length, 3);
    });

    test('Adding a participant should increase count to 4', () {
      ParticipantService participantService = ParticipantService();
      participantService.addParticipant(Participant(
        bib: '004',
        name: 'Bob Brown',
        timer: Duration.zero,
        status: false,
      ));
      expect(participantService.participants.length, 4);
    });

    test('Removing a participant should decrease count to 3', () {
      ParticipantService participantService = ParticipantService();
      participantService.addParticipant(Participant(
        bib: '004',
        name: 'Bob Brown',
        timer: Duration.zero,
        status: false,
      ));
      participantService.removeParticipant(0);
      expect(participantService.participants.length, 3);
    });

    test('Removing all participants should set count to 0', () {
      ParticipantService participantService = ParticipantService();
      participantService.removeAllParticipants();
      expect(participantService.participants.length, 0);
    });
  });
}