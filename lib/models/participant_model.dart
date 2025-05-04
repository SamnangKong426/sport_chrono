class Participant {
  final String bib;
  final String name;

  Participant({required this.bib, required this.name});

  Map<String, dynamic> toJson() {
    return {'bib': bib, 'name': name};
  }

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(bib: json['bib'], name: json['name']);
  }
}
