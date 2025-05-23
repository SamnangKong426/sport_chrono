import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/participant_model.dart';
import '../services/participant_service.dart';
import '../services/timer_service.dart';

enum Activity { Swimming, Cycling, Running }

class TimerViewModel extends ChangeNotifier {
  bool get isRunning => TimerService.instance.running;

  Activity selectedActivity = Activity.Swimming;

  static const int itemsPerPage = 20;
  int pageIndex = 0;

  final Set<int> selectedIntervals = {};

  bool isRecordMode = false;
  final Map<int, Duration> recordedTimes = {};

  List<Participant> participants = [];

  TimerViewModel() {
    TimerService.instance.addListener(notifyListeners);
    loadParticipants();
  }

  Future<void> refresh() => loadParticipants();

  /// Fetch from Firestore and replace local list
  Future<void> loadParticipants() async {
    try {
      final data = await ParticipantService.getParticipants();
      debugPrint('🔍 Loaded participants (${data.length}):');
      for (var p in data) {
        debugPrint(' • ${p.toString()}');
      }
      participants = data;

      // ←— sort by bib ascending
      participants.sort((a, b) => a.bib.compareTo(b.bib));

      // reset paging
      pageIndex = 0;
      notifyListeners();
    } catch (e, st) {
      debugPrint('❌ Error loading participants: $e\n$st');
    }
  }

  /// Flip the `status` of the participant with [bib].
  void toggleParticipantStatus(int bib) {
    final p = participants.firstWhere((p) => p.bib == bib);
    p.status = !p.status;
    debugPrint('Participant ${p.bib} status: ${p.status}');
    notifyListeners();
  }

  // Computed getters
  String get timerText {
    final e = TimerService.instance.elapsed;
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(e.inHours)}:${two(e.inMinutes % 60)}:${two(e.inSeconds % 60)}';
  }

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
  void start() => TimerService.instance.start();
  void pause() => TimerService.instance.pause();
  void reset() => TimerService.instance.reset();

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

  void toggleRecordMode() {
    isRecordMode = !isRecordMode;
    notifyListeners();
  }

  Future<void> recordTime(int bib) async {
    final p = participants.firstWhere((p) => p.bib == bib);

    // grab the runtime value from the singleton
    final current = TimerService.instance.elapsed;

    switch (selectedActivity) {
      case Activity.Swimming:
        p.swimmingTimer = current;
        break;
      case Activity.Cycling:
        p.cyclingTimer = current;
        break;
      case Activity.Running:
        p.runningTimer = current;
        break;
    }
    p.totalTimer = p.swimmingTimer + p.cyclingTimer + p.runningTimer;

    debugPrint(
      '🕒 Recorded ${selectedActivity.name} for #$bib → '
      '${_twoDigits(current.inHours)}:'
      '${_twoDigits(current.inMinutes % 60)}:'
      '${_twoDigits(current.inSeconds % 60)}',
    );

    notifyListeners();

    try {
      await ParticipantService.updateParticipant(p);
      debugPrint('✅ Synced participant #$bib to Firestore');
    } catch (e) {
      debugPrint('❌ Failed to sync #$bib: $e');
    }
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    // unregister before the VM dies
    TimerService.instance.removeListener(notifyListeners);
    super.dispose();
  }

  Future<void> resetParticipantTime(int bib) async {
    final p = participants.firstWhere((p) => p.bib == bib);

    switch (selectedActivity) {
      case Activity.Swimming:
        p.swimmingTimer = Duration.zero;
        break;
      case Activity.Cycling:
        p.cyclingTimer = Duration.zero;
        break;
      case Activity.Running:
        p.runningTimer = Duration.zero;
        break;
    }

    // Recalculate total timer after reset
    p.totalTimer = p.swimmingTimer + p.cyclingTimer + p.runningTimer;

    debugPrint('🔄 Reset ${selectedActivity.name} timer for #$bib');

    notifyListeners();

    try {
      await ParticipantService.updateParticipant(p);
      debugPrint('✅ Synced reset timer for #$bib to Firestore');
    } catch (e) {
      debugPrint('❌ Failed to sync reset for #$bib: $e');
    }
  }
}
