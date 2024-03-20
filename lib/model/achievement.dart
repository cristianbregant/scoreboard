class Achievement {
  final String? name;
  final String? description;
  final String? company;
  final String? icon;
  final int? points;
  final DateTime? date;
  final String? id;
  final bool? verified;

  Achievement(
      {this.name,
      this.description,
      this.company,
      this.icon,
      this.points,
      this.date,
      this.id,
      this.verified});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      company: json['company'],
      points: json['points'],
      date: json['date'],
      id: json['id'],
      verified: json['verified'],
    );
  }
}
