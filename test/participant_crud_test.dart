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
                ParticipantService.getParticipants().then((value) {
                  print(value);
                });
              },
              child: Text('Get Participants'),
            ),
            TextButton(
              onPressed: () {
                ParticipantService.addParticipant(
                  Participant(bib: 1, name: 'John Doe', status: true),
                );
              },
              child: Text('Add Participant'),
            ),
            TextButton(
              onPressed: () {
                ParticipantService.removeParticipant(1);
              },
              child: Text('Remove Participant'),
            ),
            TextButton(
              onPressed: () {
                ParticipantService.removeAllParticipants();
              },
              child: Text('Remove All Participants'),
            ),
          ],
        ),
      ),
    );
  }
}
