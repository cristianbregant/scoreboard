/// Paths of the Scoreboard backend, see `scoreboard_backend/README.md`.
class ApiEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String password = '/auth/password';
  static const String me = '/me';

  static const String users = '/users';
  static String userTeam(String userId) => '/users/$userId/team';
  static const String companies = '/companies';

  static const String achievements = '/achievements';
  static String reaction(String achievementId) =>
      '/achievements/$achievementId/reaction';
  static const String templates = '/templates';
  static String template(String templateId) => '/templates/$templateId';

  static String catalog(String companyId) => '/companies/$companyId/catalog';
  static String catalogAchievement(String id) => '/catalog/$id';
  static String requests(String companyId) => '/companies/$companyId/requests';
  static String request(String id) => '/requests/$id';

  static const String reactions = '/reactions';
  static const String comments = '/comments';
  static const String notifications = '/notifications';

  static String teams(String companyId) => '/companies/$companyId/teams';
  static String team(String id) => '/teams/$id';
  static String seasons(String companyId) => '/companies/$companyId/seasons';
  static String season(String id) => '/seasons/$id';
  static String activity(String companyId) => '/companies/$companyId/activity';
  static const String newActivity = '/activity';
  static String settings(String companyId) => '/companies/$companyId/settings';
  static String invites(String companyId) => '/companies/$companyId/invites';
  static String invite(String id) => '/invites/$id';
  static String userAdmin(String userId) => '/users/$userId/admin';
}
