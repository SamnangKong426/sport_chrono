import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/viewmodels/results_viewmodel.dart';
import 'package:sport_chrono/views/results_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ResultsViewModel()),
        // TODO: add more providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport Chrono',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ResultsView(),
    );
  }
}
