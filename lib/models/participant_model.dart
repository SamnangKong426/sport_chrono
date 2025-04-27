class Participant {
  final String bib;
  final String name;
  final Duration timer;
  final bool status;

  Participant({
    required this.bib,
    required this.name,
    required this.timer,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'bib': bib,
      'name': name,
      'timer': timer.inSeconds,
      'status': status,
    };
  }

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      bib: json['bib'],
      name: json['name'],
      timer: Duration.zero,
      status: false,
    );
  }
}
