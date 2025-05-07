import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/participant_model.dart';

enum Activity { Swimming, Cycling, Running }

class TimerViewModel extends ChangeNotifier {
  // Timer state
  Duration elapsed = Duration.zero;
  Timer? _ticker;
  bool get isRunning => _ticker?.isActive ?? false;

  // Activity tabs
  Activity selectedActivity = Activity.Swimming;

  // Paging through participants instead of intervals
  static const int itemsPerPage = 20;
  int pageIndex = 0;

  // Selected/highlighted intervals
  final Set<int> selectedIntervals = {};

  // simple participants list
  List<Participant> participants = List.generate(
    41,
    (i) => Participant(bib: i + 1, name: 'Participant ${i + 1}'),
  );

  /// Flip the `status` of the participant with [bib].
  void toggleParticipantStatus(int bib) {
    final p = participants.firstWhere((p) => p.bib == bib);
    p.status = !p.status;
    debugPrint('Participant ${p.bib} status: ${p.status}');
    notifyListeners();
  }

  // Computed getters
  String get timerText =>
      '${_twoDigits(elapsed.inHours)}:'
      '${_twoDigits(elapsed.inMinutes % 60)}:'
      '${_twoDigits(elapsed.inSeconds % 60)}';

  /// Labels like “01 - 04”, “05 - 08”, … based on participants count
  List<String> get pageLabels {
    final pageCount = (participants.length / itemsPerPage).ceil();
    return List.generate(pageCount, (i) {
      final start = i * itemsPerPage + 1;
      final end = min(participants.length, (i + 1) * itemsPerPage);
      return '${_twoDigits(start)} - ${_twoDigits(end)}';
    });
  }

  String get currentPageLabel => pageLabels[pageIndex];

  /// The slice of participants for the current page
  List<Participant> get currentParticipants {
    final start = pageIndex * itemsPerPage;
    return participants.skip(start).take(itemsPerPage).toList();
  }

  // Actions
  void start() {
    if (isRunning) return;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsed += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void pause() {
    _ticker?.cancel();
    notifyListeners();
  }

  void reset() {
    _ticker?.cancel();
    elapsed = Duration.zero;
    notifyListeners();
  }

  void selectActivity(Activity a) {
    selectedActivity = a;
    notifyListeners();
  }

  void nextPage() {
    if (pageIndex < pageLabels.length - 1) {
      pageIndex++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (pageIndex > 0) {
      pageIndex--;
      notifyListeners();
    }
  }

  /// Jump directly to [index] if valid.
  void goToPage(int index) {
    final maxPage = pageLabels.length - 1;
    if (index >= 0 && index <= maxPage) {
      pageIndex = index;
      notifyListeners();
    }
  }

  void toggleInterval(int number) {
    if (!selectedIntervals.remove(number)) {
      selectedIntervals.add(number);
    }
    notifyListeners();
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
