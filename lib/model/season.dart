/// A period with its own leaderboard, set by the company admins, e.g.
/// "Autumn 2026". Seasons of a company never overlap.
class Season {
  final String id;
  final String companyId;
  final String name;

  /// First day, inclusive.
  final DateTime start;

  /// Last day, inclusive.
  final DateTime end;

  const Season(
      {required this.id,
      required this.companyId,
      required this.name,
      required this.start,
      required this.end});

  DateTime get _endExclusive => DateTime(end.year, end.month, end.day + 1);

  bool contains(DateTime time) =>
      !time.isBefore(start) && time.isBefore(_endExclusive);

  bool overlaps(Season other) =>
      start.isBefore(other._endExclusive) &&
      other.start.isBefore(_endExclusive);

  SeasonStatus statusAt(DateTime now) => contains(now)
      ? SeasonStatus.active
      : now.isBefore(start)
          ? SeasonStatus.upcoming
          : SeasonStatus.ended;

  /// Days left including today, 0 once ended.
  int daysLeft(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final days = _endExclusive.difference(today).inDays;
    return days < 0 ? 0 : days;
  }

  Season copyWith({String? name, DateTime? start, DateTime? end}) => Season(
        id: id,
        companyId: companyId,
        name: name ?? this.name,
        start: start ?? this.start,
        end: end ?? this.end,
      );

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json['id'],
        companyId: json['company_id'],
        name: json['name'],
        start: DateTime.parse(json['start']),
        end: DateTime.parse(json['end']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_id': companyId,
        'name': name,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
      };
}

enum SeasonStatus { upcoming, active, ended }

/// Fields of a season, as entered by an admin.
class SeasonDraft {
  final String name;
  final DateTime start;
  final DateTime end;

  const SeasonDraft(
      {required this.name, required this.start, required this.end});
}
