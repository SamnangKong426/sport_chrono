class Participant {
  final int bib;
  final String name;
  Duration swimmingTimer;
  Duration cyclingTimer;
  Duration runningTimer;
  Duration totalTimer;
  bool status;

  Participant({
    required this.bib,
    required this.name,
    this.status = false,
    this.swimmingTimer = Duration.zero,
    this.cyclingTimer = Duration.zero,
    this.runningTimer = Duration.zero,
    this.totalTimer = Duration.zero,
  });

  Map<String, dynamic> toJson() {
    return {
      'bib': bib,
      'name': name,
      'swimming_timer': swimmingTimer.inSeconds,
      'cycling_timer': cyclingTimer.inSeconds,
      'running_timer': runningTimer.inSeconds,
      'total_timer': totalTimer.inSeconds,
      'status': status,
    };
  }

  // factory Participant.fromJson(Map<String, dynamic> json) {
  //   return Participant(
  //     bib: json['bib'] as int,
  //     name: json['name'] as String,
  //     swimmingTimer: Duration(seconds: json['swimming_timer'] as int),
  //     cyclingTimer: Duration(seconds: json['cycling_timer'] as int),
  //     runningTimer: Duration(seconds: json['running_timer'] as int),
  //     status: json['status'] as bool,
  //   );
  // }
  factory Participant.fromJson(Map<String, dynamic> json) {
    final swim = Duration(seconds: json['swimming_timer'] as int);
    final cycle = Duration(seconds: json['cycling_timer'] as int);
    final run = Duration(seconds: json['running_timer'] as int);

    return Participant(
      bib: json['bib'] as int,
      name: json['name'] as String,
      swimmingTimer: swim,
      cyclingTimer: cycle,
      runningTimer: run,
      totalTimer: swim + cycle + run,
      status: json['status'] as bool,
    );
  }

  @override
  String toString() {
    return 'Participant(bib: $bib, name: $name, '
        'swim: ${swimmingTimer.inSeconds}s, '
        'cycle: ${cyclingTimer.inSeconds}s, '
        'run: ${runningTimer.inSeconds}s, '
        'total: ${totalTimer.inSeconds}s, '
        'status: $status)';
  }
}
