/// Gamified level derived from the total points of a user.
class PlayerLevel {
  static const int pointsPerLevel = 300;

  final int points;

  const PlayerLevel(this.points);

  int get level => 1 + points ~/ pointsPerLevel;
  int get pointsIntoLevel => points % pointsPerLevel;
  int get pointsToNextLevel => pointsPerLevel - pointsIntoLevel;
  double get progress => pointsIntoLevel / pointsPerLevel;
}
