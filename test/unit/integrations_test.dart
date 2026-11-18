import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/chat_integration.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

const _teams =
    'https://prod-01.westeurope.logic.azure.com/workflows/abc/triggers/manual/paths/invoke?sig=secret';
const _slack = 'https://hooks.slack.com/services/T000/B000/secret';

void main() {
  late IntegrationInteractor integrations;

  setUp(() async {
    await setUpApp();
    integrations = getIt<IntegrationInteractor>();
  });

  test('nothing is connected at first; verified achievements would post',
      () async {
    final chat = await integrations.chat();
    expect(chat.teamsConnected, isFalse);
    expect(chat.slackConnected, isFalse);
    expect(chat.postVerified, isTrue);
    expect(chat.postPeer, isFalse);
  });

  test('only Teams and Slack webhooks connect, and URLs aren\'t shown back',
      () async {
    await expectLater(
        integrations.connect(ChatChannel.slack, 'https://evil.example/hook'),
        throwsAdminError(AdminError.invalidWebhook));
    await expectLater(integrations.connect(ChatChannel.teams, _slack),
        throwsAdminError(AdminError.invalidWebhook));

    await integrations.connect(ChatChannel.teams, _teams);
    final chat = await integrations.connect(ChatChannel.slack, _slack);
    expect(chat.teamsConnected && chat.slackConnected, isTrue);
    expect(chat.slackHint, 'hooks.slack.com/…');
    expect(chat.teamsHint, isNot(contains('secret')));
    final activity = await getIt<ActivityInteractor>().getActivity();
    expect(activity.first.type, ActivityType.integrationsUpdated);

    final after = await integrations.disconnect(ChatChannel.slack);
    expect(after.slackConnected, isFalse);
    expect(after.teamsConnected, isTrue);
  });

  test('what is posted and in which language', () async {
    await integrations.setPosting(peer: true);
    await integrations.setLanguage('it');
    final chat = await integrations.chat();
    expect(chat.postPeer, isTrue);
    expect(chat.postVerified, isTrue);
    expect(chat.language, 'it');
  });

  test('the demo says test messages need the server', () async {
    await integrations.connect(ChatChannel.slack, _slack);
    await expectLater(integrations.sendTest(ChatChannel.slack),
        throwsAdminError(AdminError.needsBackend));
  });

  test('members cannot see or change the integration', () async {
    await setUpApp(prefs: {
      ...await savedPrefs(),
      'session_user_id': 'u_02',
      'onboarding_done_u_02': true,
    });
    await expectLater(getIt<IntegrationInteractor>().chat(),
        throwsAdminError(AdminError.notAdmin));
  });
}
