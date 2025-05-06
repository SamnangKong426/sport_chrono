import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/viewmodels/race_viewmodel.dart';
import 'package:sport_chrono/viewmodels/participant_viewmodel.dart';
import 'package:sport_chrono/viewmodels/results_viewmodel.dart';
import 'package:sport_chrono/views/participant_view.dart';
import 'package:sport_chrono/views/race_view.dart';
// import 'package:sport_chrono/views/timer_view.dart';
import 'package:sport_chrono/views/results_view.dart';
import 'package:sport_chrono/widgets/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RaceViewModel()),
        ChangeNotifierProvider(create: (_) => ParticipantViewModel()),
        ChangeNotifierProvider(create: (_) => ResultsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const _pages = <Widget>[
    ParticipantView(),
    RaceView(),
    // TimerView(),
    ResultsView(),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    // when switching to Results tab (index 3), reload data
    if (index == 3) {
      context.read<ResultsViewModel>().refresh();
    } else if (index == 1) {
      context.read<RaceViewModel>().refresh();
    } else if (index == 0) {
      context.read<ParticipantViewModel>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
