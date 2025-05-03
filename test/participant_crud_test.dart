import 'package:flutter/material.dart';
import 'package:sport_chrono/firebase_options.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  ParticipantService participantService = ParticipantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                participantService.getParticipants().then((value) {
                  print(value);
                });
              },
              child: Text('Get Participants'),
            ),
            TextButton(
              onPressed: () {
                participantService.addParticipant(
                  Participant(
                    bib: 1,
                    name: 'John Doe',
                    timer: Duration.zero,
                    status: false,
                  ),
                );
              },
              child: Text('Add Participant'),
            ),
            TextButton(
              onPressed: () {
                participantService.removeParticipant(1);
              },
              child: Text('Remove Participant'),
            ),
            TextButton(
              onPressed: () {
                participantService.removeAllParticipants();
              },
              child: Text('Remove All Participants'),
            ),
          ],
        ),
      ),
    );
  }
}
