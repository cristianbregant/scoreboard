class Constants {
  /// GitHub repository whose releases the app checks for updates.
  static const String githubRepository = 'cristianbregant/scoreboard';

  /// Address of the Scoreboard backend, e.g. `http://localhost:3000`, set
  /// with `--dart-define=SCOREBOARD_API_URL=…`. Empty runs the app on the
  /// local mock backend.
  static const String apiUrl = String.fromEnvironment('SCOREBOARD_API_URL');
}
