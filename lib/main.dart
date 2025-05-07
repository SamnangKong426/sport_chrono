import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/timer_viewmodel.dart';
import 'views/timer_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerViewModel()),
        // TODO: add other providers here
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
      title: 'Timer App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const TimerView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
