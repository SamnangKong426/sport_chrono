import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TimerService extends ChangeNotifier {
  /// The single, shared instance
  static final TimerService instance = TimerService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String docId = 'default';
  Duration elapsed = Duration.zero;
  bool running = false;
  Timer? _ticker;

  /// private named ctor
  TimerService._internal() {
    _load();
  }

  Future<void> _load() async {
    final snap = await _db.collection('timers').doc(docId).get();
    if (snap.exists) {
      final data = snap.data()!;
      elapsed = Duration(seconds: data['elapsed'] ?? 0);
      running = data['running'] ?? false;
      notifyListeners();
      if (running) _startTicker();
    }
  }

  void start() {
    if (running) return;
    running = true;
    _startTicker();
    _save();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsed += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void pause() {
    if (!running) return;
    running = false;
    _ticker?.cancel();
    notifyListeners();
    _save();
  }

  void reset() {
    running = false;
    _ticker?.cancel();
    elapsed = Duration.zero;
    notifyListeners();
    _save();
  }

  Future<void> _save() {
    return _db.collection('timers').doc(docId).set({
      'elapsed': elapsed.inSeconds,
      'running': running,
      'updated_at': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
