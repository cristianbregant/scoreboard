class ApiEndpoints {
  static const String achievements = '/achievements';
  static String achievement(String achievementID) =>
      '/achievements/$achievementID';

  static const String profile = '/profile';

  static const String myCompany = '/my_company';

  static const String login = '/login';
  static const String logout = '/logout';
}
