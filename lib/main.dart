import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_chrono/themes/app_theme.dart';
import 'package:sport_chrono/viewmodels/race_viewmodel.dart';
import 'package:sport_chrono/viewmodels/participant_viewmodel.dart';
import 'package:sport_chrono/viewmodels/results_viewmodel.dart';
import 'package:sport_chrono/views/participant_view.dart';
import 'package:sport_chrono/views/race_view.dart';
import 'package:sport_chrono/views/timer_view.dart';
import 'package:sport_chrono/viewmodels/timer_viewmodel.dart';
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
        ChangeNotifierProvider(create: (_) => TimerViewModel()),
        ChangeNotifierProvider(create: (_) => RaceViewModel()),
        ChangeNotifierProvider(create: (_) => ParticipantViewModel()),
        ChangeNotifierProvider(create: (_) => ResultsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomeScaffold(),
      ),
    );
  }
}

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _currentIndex = 0;
  final _pages = const [
    ParticipantView(),
    RaceView(),
    TimerView(),
    ResultsView(),
  ];

  void _onTap(int idx) {
    setState(() => _currentIndex = idx);
    switch (idx) {
      case 0:
      context.read<ParticipantViewModel>().refresh();
      break;
      case 1:
      context.read<RaceViewModel>().refresh();
      break;
      case 2:
      context.read<TimerViewModel>().refresh();
      break;
      case 3:
      context.read<ResultsViewModel>().refresh();
      break;
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
