import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/send_achievement.dart';

Matcher throwsAuthError(AuthError error) =>
    throwsA(isA<AuthException>().having((e) => e.error, 'error', error));

Matcher throwsSendError(SendAchievementError error) => throwsA(
    isA<SendAchievementException>().having((e) => e.error, 'error', error));

Matcher throwsAdminError(AdminError error) =>
    throwsA(isA<AdminException>().having((e) => e.error, 'error', error));
