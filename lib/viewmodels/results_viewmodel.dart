import 'dart:io' show File, Directory, Platform;
import 'dart:convert' show utf8;
import 'package:flutter/foundation.dart'
    show ChangeNotifier, debugPrint, kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:sport_chrono/models/participant_model.dart';
import 'package:sport_chrono/services/participant_service.dart';
import 'dart:html' as html;

class ResultsViewModel extends ChangeNotifier {
  List<Participant> _allParticipants = [];
  List<Participant> _filtered = [];

  ResultsViewModel() {
    _loadParticipants();
  }

  Future<void> _loadParticipants() async {
    _allParticipants = await ParticipantService.getParticipants();
    _allParticipants.sort((a, b) => a.totalTimer.compareTo(b.totalTimer));
    _filtered = List.from(_allParticipants);
    notifyListeners();
  }

  Future<void> refresh() => _loadParticipants();

  List<Participant> get results => _filtered;

  void search(String query) {
    if (query.isEmpty) {
      _filtered = List.from(_allParticipants);
    } else {
      final q = query.toLowerCase();
      _filtered =
          _allParticipants.where((p) {
            return p.bib.toString().contains(q) ||
                p.name.toLowerCase().contains(q);
          }).toList();
    }
    notifyListeners();
  }

  /// Exports all participants to a timestamped CSV in Downloads.
  Future<void> exportResultsToFile() async {
    // 1) build CSV content
    final csvBuffer =
        StringBuffer()..writeln('BIB,Name,Swimming,Running,Cycling,Total');
    for (final p in _allParticipants) {
      csvBuffer.writeln(
        [
          p.bib,
          '"${p.name.replaceAll('"', '""')}"',
          _formatDuration(p.swimmingTimer),
          _formatDuration(p.runningTimer),
          _formatDuration(p.cyclingTimer),
          _formatDuration(p.totalTimer),
        ].join(','),
      );
    }

    // 2) if web, fire a download via an <a> tag
    final timestamp = DateTime.now().toIso8601String().replaceAll(
      RegExp(r'[:\.]'),
      '-',
    );
    final filename = 'sport_chrono_results_$timestamp.csv';

    if (kIsWeb) {
      final bytes = utf8.encode(csvBuffer.toString());
      final blob = html.Blob([bytes], 'text/csv');
      final url = html.Url.createObjectUrl(blob);
      final anchor =
          html.document.createElement('a') as html.AnchorElement
            ..href = url
            ..download = filename
            ..style.display = 'none';
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(url);
      return;
    }

    // 3) Otherwise (mobile/desktop), write to local Downloads
    Directory targetDir;
    if (Platform.isLinux || Platform.isAndroid) {
      final home = Platform.environment['HOME'] ?? '';
      targetDir = Directory('$home/Downloads');
    } else {
      targetDir =
          (await getDownloadsDirectory()) ??
          await getApplicationDocumentsDirectory();
    }
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }
    final file = File('${targetDir.path}/$filename');
    await file.writeAsString(csvBuffer.toString());
    debugPrint('✅ Exported CSV to: ${file.path}');
  }

  String _formatDuration(Duration d) =>
      d != Duration.zero
          ? d.toString().split('.').first.padLeft(8, '0')
          : '00:00:00';
}
