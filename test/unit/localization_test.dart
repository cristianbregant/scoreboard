import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';

Map<String, dynamic> _arb(String locale) =>
    jsonDecode(File('lib/l10n/intl_$locale.arb').readAsStringSync());

Set<String> _messages(Map<String, dynamic> arb) =>
    arb.keys.where((k) => !k.startsWith('@')).toSet();

/// Placeholders such as {name}; plural branches like one{...} don't count.
Set<String> _placeholders(String message) => RegExp(r'(?<!\w)\{(\w+)[,}]')
    .allMatches(message)
    .map((m) => m.group(1)!)
    .toSet();

void main() {
  setUpAll(initializeDateFormatting);

  group('translations', () {
    final en = _arb('en');
    final locales = Directory('lib/l10n')
        .listSync()
        .map((f) => RegExp(r'intl_(\w+)\.arb$').firstMatch(f.path)?.group(1))
        .whereType<String>()
        .where((locale) => locale != 'en')
        .toList()
      ..sort();

    test('every supported language has a file', () {
      expect(locales, containsAll(['de', 'es', 'fr', 'it']));
      expect(
          AppLocalization.delegate.supportedLocales.map((l) => l.languageCode),
          containsAll(['en', ...locales]));
    });

    for (final locale in locales) {
      final arb = _arb(locale);

      test('$locale has the same messages as English', () {
        expect(_messages(arb).difference(_messages(en)), isEmpty,
            reason: 'only in $locale');
        expect(_messages(en).difference(_messages(arb)), isEmpty,
            reason: 'missing in $locale');
      });

      test('$locale keeps the placeholders', () {
        for (final key in _messages(en)) {
          expect(_placeholders(arb[key] as String),
              _placeholders(en[key] as String),
              reason: key);
        }
      });
    }
  });

  group('messages', () {
    // Generated messages follow the loaded locale, not the instance.
    Future<AppLocalization> load(String code) =>
        AppLocalization.load(Locale(code));
    late AppLocalization en;

    setUp(() async => en = await load('en'));

    test('errors are localized', () async {
      const budget =
          SendAchievementException(SendAchievementError.budgetExhausted);
      final english = budget.localized(en);
      expect(english, contains('${SendAchievementOptions.monthlyBudget}'));
      final sentence = budget.localized(await load('it'));
      expect(sentence, isNot(english));
      expect(sentence, contains('${SendAchievementOptions.monthlyBudget}'));
      en = await load('en');

      const sent = SendAchievementException(SendAchievementError.alreadySent,
          templateName: 'Great Idea', colleagueName: 'Giulia');
      expect(sent.localized(en),
          allOf(contains('Great Idea'), contains('Giulia')));

      expect(const AuthException(AuthError.passwordTooShort).localized(en),
          contains('8'));
    });

    test('tiers have names in every language', () async {
      expect(AchievementTier.gold.localized(en), 'Gold');
      expect(AchievementTier.gold.localized(await load('it')), 'Oro');
      expect(AchievementTier.platinum.localized(await load('de')), 'Platin');
      expect(AchievementTier.silver.localized(await load('fr')), 'Argent');
      expect(AchievementTier.bronze.localized(await load('es')), 'Bronce');
    });

    test('every notification type has a title and a body', () async {
      for (final type in NotificationType.values) {
        final notification = AppNotification(
            id: 'n',
            userId: 'u',
            type: type,
            createdAt: DateTime.now(),
            actorName: 'Giulia',
            achievementName: 'Bug Hunter',
            number: 3,
            secondNumber: 2,
            text: 'Nice');
        for (final code in ['en', 'it', 'es', 'fr', 'de']) {
          final l10n = await load(code);
          expect(notification.title(l10n), isNotEmpty, reason: '$type');
          expect(notification.body(l10n), isNotEmpty, reason: '$type');
        }
      }
    });

    test('rejections mention the reason when there is one', () {
      AppNotification rejected(String? reason) => AppNotification(
          id: 'n',
          userId: 'u',
          type: NotificationType.requestRejected,
          createdAt: DateTime.now(),
          achievementName: 'Bug Hunter',
          text: reason);
      expect(rejected('Needs a link').body(en), contains('Needs a link'));
      expect(rejected(null).body(en), contains('Bug Hunter'));
    });

    test('relative times', () async {
      final now = DateTime.now();
      expect(timeAgo(en, now), 'Just now');
      expect(
          timeAgo(en, now.subtract(const Duration(minutes: 5))), '5 min ago');
      expect(timeAgo(en, now.subtract(const Duration(hours: 3))), '3 h ago');
      expect(timeAgo(en, now.subtract(const Duration(days: 1))), 'Yesterday');
      expect(timeAgo(en, now.subtract(const Duration(days: 3))), '3 days ago');
      expect(timeAgo(en, now.subtract(const Duration(days: 30))),
          isNot(contains('ago')));
      final it = await load('it');
      expect(timeAgo(it, now.subtract(const Duration(days: 1))), 'Ieri');
    });
  });
}
