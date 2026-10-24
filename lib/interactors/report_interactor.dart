import 'dart:convert';
import 'dart:typed_data';

import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/share_service.dart';

/// Which CSV report, see [ReportInteractor].
enum ReportKind {
  /// One row per achievement received in the period.
  achievements,

  /// One row per person, with their totals for the period.
  people,
}

/// Exports for HR: CSV reports over a period and, for data protection
/// requests, everything the app holds about one person. Admins only, and
/// every export is written to the activity log.
class ReportInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ShareService _share;
  final ActivityInteractor _activity;

  ReportInteractor(
      this._repository, this._scoreboard, this._share, this._activity);

  /// Achievements dated from [from] to [to], both days included.
  Future<String> buildCsv(ReportKind kind,
      {required DateTime from, required DateTime to}) async {
    final admin = await _requireAdmin();
    final members = (await _repository.getUsers())
        .where((u) => u.companyId == admin.companyId)
        .toList();
    final teams = {
      for (final t in await _repository.getTeams(admin.companyId)) t.id: t.name
    };
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day + 1);
    final inPeriod = (await _repository.getAchievements())
        .where((a) =>
            a.date != null && !a.date!.isBefore(start) && a.date!.isBefore(end))
        .toList();
    String team(UserProfile u) => teams[u.teamId] ?? '';

    return switch (kind) {
      ReportKind.achievements => _csv([
          [
            'Date',
            'Recipient',
            'Email',
            'Team',
            'Achievement',
            'Kind',
            'XP',
            'From'
          ],
          for (final a in inPeriod..sort((a, b) => a.date!.compareTo(b.date!)))
            if (members.where((m) => m.id == a.userId).firstOrNull
                case final member?)
              [
                _date(a.date!),
                member.name,
                member.email,
                team(member),
                a.name ?? '',
                a.verified == true ? 'verified' : 'peer',
                '${a.points ?? 0}',
                (a.verified == true ? a.company : a.awardedByName) ?? '',
              ],
        ]),
      ReportKind.people => _csv([
          [
            'Name',
            'Email',
            'Team',
            'Received',
            'Verified',
            'Peer',
            'XP',
            'Sent',
            'Last recognized'
          ],
          for (final member
              in members..sort((a, b) => a.name.compareTo(b.name)))
            () {
              final received =
                  inPeriod.where((a) => a.userId == member.id).toList();
              final verified = received.where((a) => a.verified == true);
              final last = received.isEmpty
                  ? null
                  : received
                      .map((a) => a.date!)
                      .reduce((a, b) => a.isAfter(b) ? a : b);
              return [
                member.name,
                member.email,
                team(member),
                '${received.length}',
                '${verified.length}',
                '${received.length - verified.length}',
                '${received.fold(0, (sum, a) => sum + (a.points ?? 0))}',
                '${inPeriod.where((a) => a.verified != true && a.awardedById == member.id).length}',
                last == null ? '' : _date(last),
              ];
            }(),
        ]),
    };
  }

  /// Everything about [userId]: profile, achievements, requests, comments
  /// and reactions. Passwords never leave the backend.
  Future<Map<String, dynamic>> buildPersonalData(String userId) async {
    final admin = await _requireAdmin();
    final user = (await _repository.getUsers())
        .where((u) => u.id == userId && u.companyId == admin.companyId)
        .firstOrNull;
    if (user == null) throw const AdminException(AdminError.notFound);
    final achievements = await _repository.getAchievements();
    final team = (await _repository.getTeams(user.companyId))
        .where((t) => t.id == user.teamId)
        .firstOrNull;
    Map<String, dynamic> achievementJson(Achievement a) => {
          'id': a.id,
          'name': a.name,
          'kind': a.verified == true ? 'verified' : 'peer',
          'points': a.points,
          'date': a.date?.toIso8601String(),
          'from': a.verified == true ? a.company : a.awardedByName,
          'note': a.note,
        };
    return {
      'exported_at': DateTime.now().toUtc().toIso8601String(),
      'profile': {
        ...user.toJson(),
        // Local file paths mean nothing outside this computer.
        'avatar_path': null,
        'banner_image_path': null,
        'team': team?.name,
      },
      'achievements_received': [
        for (final a in achievements.where((a) => a.userId == userId))
          achievementJson(a)
      ],
      'achievements_sent': [
        for (final a in achievements.where((a) => a.awardedById == userId))
          {...achievementJson(a), 'to': a.userId}
      ],
      'requests': [
        for (final r in await _repository.getRequests(user.companyId))
          if (r.userId == userId) r.toJson()
      ],
      'comments': [
        for (final c in await _repository.getComments())
          if (c.userId == userId) c.toJson()
      ],
      'reactions': [
        for (final r in await _repository.getReactions())
          if (r.userId == userId) r.toJson()
      ],
    };
  }

  /// Asks where to save the report; returns the path, null if cancelled.
  Future<String?> saveCsv(ReportKind kind,
      {required DateTime from, required DateTime to}) async {
    final csv = await buildCsv(kind, from: from, to: to);
    final path = await _share.saveFile(Uint8List.fromList(utf8.encode('﻿$csv')),
        suggestedName:
            'scoreboard-${kind.name}-${_date(from)}_${_date(to)}.csv',
        type: ShareFileType.csv);
    if (path != null) {
      await _activity.log(ActivityType.reportExported,
          subject: kind.name, target: '${_date(from)} – ${_date(to)}');
    }
    return path;
  }

  Future<String?> savePersonalData(String userId) async {
    final data = await buildPersonalData(userId);
    final name = data['profile']['name'] as String;
    final path = await _share.saveFile(
        Uint8List.fromList(
            utf8.encode(const JsonEncoder.withIndent('  ').convert(data))),
        suggestedName: 'scoreboard-personal-data-$userId.json',
        type: ShareFileType.json);
    if (path != null) {
      await _activity.log(ActivityType.personalDataExported, target: name);
    }
    return path;
  }

  Future<UserProfile> _requireAdmin() async {
    final user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return user;
  }

  static String _date(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  /// RFC 4180, with CRLF line ends. Cells starting like a formula get a
  /// leading apostrophe, so spreadsheets don't run them.
  static String _csv(List<List<String>> rows) {
    String cell(String value) {
      var v = value;
      if (v.isNotEmpty && '=+-@\t\r'.contains(v[0])) v = "'$v";
      if (v.contains(RegExp(r'[",\r\n]'))) {
        v = '"${v.replaceAll('"', '""')}"';
      }
      return v;
    }

    return rows.map((r) => r.map(cell).join(',')).join('\r\n');
  }
}
