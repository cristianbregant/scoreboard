import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/views/achievement/achievement_view.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

import '../helpers/test_app.dart';

/// The window's minimum size, set in `main`.
const _minimumWindow = Size(1000, 600);

void main() {
  setUpAll(loadAppFonts);

  for (final language in ['en', 'it', 'es', 'fr', 'de']) {
    testWidgets('every page fits the smallest window in "$language"',
        (tester) async {
      await pumpApp(tester, prefs: {...basePrefs(), 'language_code': language});
      tester.view.physicalSize = _minimumWindow;
      await settle(tester);
      expect(tester.takeException(), isNull, reason: 'achievements');

      final items = find.descendant(
          of: find.byType(Sidebar), matching: find.byType(Text));
      for (final page in AppPage.values.skip(1)) {
        getIt<AppNavigation>().openPage(page);
        await settle(tester);
        expect(tester.takeException(), isNull, reason: page.name);
      }
      expect(items, findsWidgets);

      // Every section of the admin console.
      getIt<AppNavigation>().openPage(AppPage.console);
      await settle(tester);
      for (final section in ConsoleSection.values) {
        getIt<AppNavigation>().consoleSection.value = section;
        await settle(tester);
        expect(tester.takeException(), isNull, reason: 'admin ${section.name}');
      }

      // The detail page and the send dialog too.
      getIt<AppNavigation>().openPage(AppPage.achievements);
      await settle(tester);
      await tester.tap(find.byType(InteractiveCard).first);
      await settle(tester);
      expect(tester.takeException(), isNull, reason: 'detail');
      Navigator.of(tester.element(find.byType(AchievementView))).pop();
      await settle(tester);
      getIt<AppNavigation>().quickSend();
      await settle(tester);
      expect(find.byType(Dialog), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'send dialog');
    });
  }

  testWidgets('the sidebar scrolls instead of overflowing a short window',
      (tester) async {
    await pumpApp(tester);
    // Shorter than the minimum: the native frame may take some height.
    tester.view.physicalSize = const Size(1000, 480);
    await settle(tester);
    expect(tester.takeException(), isNull);
    expect(find.byType(UserAvatar), findsWidgets);
  });

  testWidgets('the sign-in screen fits the smallest window in German',
      (tester) async {
    await pumpApp(tester,
        prefs: {...basePrefs(signedIn: false), 'language_code': 'de'});
    tester.view.physicalSize = _minimumWindow;
    await settle(tester);
    expect(tester.takeException(), isNull);
  });
}
