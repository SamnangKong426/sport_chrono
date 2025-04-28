import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/viewmodels/race_viewmodel.dart';
import 'package:sport_chrono/views/race_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RaceViewModel()),
      ],
      child: MaterialApp(home: RaceView(), debugShowCheckedModeBanner: false),
    );
  }
}
