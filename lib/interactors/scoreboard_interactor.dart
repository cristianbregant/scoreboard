import 'package:flutter/material.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/leaderboard_entry.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/file_picker_service.dart';
import 'package:scoreboard/services/image_storage_service.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// Shared across view models: notifies listeners when the current user's
/// profile or anyone's achievements change so every screen can refresh.
class ScoreboardInteractor extends ChangeNotifier {
  final ScoreboardRepository _repository;
  final FilePickerService _filePicker;
  final ImageStorageService _imageStorage;

  ScoreboardInteractor(this._repository, this._filePicker, this._imageStorage);

  Future<UserProfile> getCurrentUser() => _repository.getCurrentUser();

  /// Saves the public profile. Newly picked images are copied into the
  /// app's storage and the ones they replace are deleted.
  Future<void> updateProfile(ProfileDraft draft) async {
    if (draft.name.trim().isEmpty || draft.role.trim().isEmpty) {
      throw const AuthException(AuthError.missingNameOrRole);
    }
    final user = await getCurrentUser();

    var avatarPath = user.avatarPath;
    if (draft.newAvatarSource != null || draft.removeAvatar) {
      await _imageStorage.delete(user.avatarPath);
      avatarPath = draft.newAvatarSource != null
          ? await _imageStorage.store(draft.newAvatarSource!,
              name: '${user.id}_avatar')
          : null;
    }
    var bannerPath = user.bannerImagePath;
    if (draft.newBannerSource != null || draft.removeBanner) {
      await _imageStorage.delete(user.bannerImagePath);
      bannerPath = draft.newBannerSource != null
          ? await _imageStorage.store(draft.newBannerSource!,
              name: '${user.id}_banner')
          : null;
    }

    await _repository.saveCurrentUser(user.copyWith(
      name: draft.name.trim(),
      role: draft.role.trim(),
      bio: draft.bio.trim(),
      bannerPreset: draft.bannerPreset,
      // An empty string clears the field.
      avatarPath: avatarPath ?? '',
      bannerImagePath: bannerPath ?? '',
    ));
    notifyListeners();
  }

  Future<void> updateEmail(String email) async {
    if (!AuthInteractor.isValidEmail(email)) {
      throw const AuthException(AuthError.invalidEmail);
    }
    final user = await getCurrentUser();
    await _repository.saveCurrentUser(user.copyWith(email: email.trim()));
    notifyListeners();
  }

  /// Path of the image the user picked, or null if cancelled.
  Future<String?> pickImage() => _filePicker.pickImage();

  Future<List<Achievement>> getAchievementsOf(String userId) async {
    final achievements = await _repository.getAchievements();
    return achievements.where((a) => a.userId == userId).toList()
      ..sort((a, b) => b.date!.compareTo(a.date!));
  }

  Future<Company> getCompany(String companyId) async {
    final companies = await _repository.getCompanies();
    return companies.firstWhere((company) => company.id == companyId);
  }

  /// Users ranked by points, optionally restricted to one company.
  Future<List<UserLeaderboardEntry>> getUserLeaderboard(
      {String? companyId}) async {
    final users = await _repository.getUsers();
    final companies = await _repository.getCompanies();
    final achievements = await _repository.getAchievements();

    final entries = users
        .where((user) => companyId == null || user.companyId == companyId)
        .map((user) {
      final owned = achievements.where((a) => a.userId == user.id);
      return (
        user: user,
        company: companies.firstWhere((c) => c.id == user.companyId),
        points: owned.fold<int>(0, (sum, a) => sum + (a.points ?? 0)),
        count: owned.length,
      );
    }).toList()
      ..sort((a, b) => b.points.compareTo(a.points));

    return [
      for (var i = 0; i < entries.length; i++)
        UserLeaderboardEntry(
          rank: i + 1,
          user: entries[i].user,
          company: entries[i].company,
          points: entries[i].points,
          achievementsCount: entries[i].count,
        )
    ];
  }

  Future<List<CompanyLeaderboardEntry>> getCompanyLeaderboard() async {
    final users = await getUserLeaderboard();
    final companies = await _repository.getCompanies();

    final entries = companies.map((company) {
      final members = users.where((e) => e.user.companyId == company.id);
      return (
        company: company,
        points: members.fold<int>(0, (sum, e) => sum + e.points),
        members: members.length,
        count: members.fold<int>(0, (sum, e) => sum + e.achievementsCount),
      );
    }).toList()
      ..sort((a, b) => b.points.compareTo(a.points));

    return [
      for (var i = 0; i < entries.length; i++)
        CompanyLeaderboardEntry(
          rank: i + 1,
          company: entries[i].company,
          points: entries[i].points,
          membersCount: entries[i].members,
          achievementsCount: entries[i].count,
        )
    ];
  }

  /// The base achievements of the current user's company, newest first.
  Future<List<AchievementTemplate>> getTemplates() async {
    final user = await getCurrentUser();
    final users = await _repository.getUsers();
    final companyMembers = {
      for (final u in users)
        if (u.companyId == user.companyId) u.id
    };
    final templates = await _repository.getTemplates();
    return templates
        .where((t) => companyMembers.contains(t.createdById))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> createTemplate(AchievementTemplateDraft draft) async {
    if (!AchievementTemplate.allowedPoints.contains(draft.points)) {
      throw const SendAchievementException(SendAchievementError.invalidPoints);
    }
    final user = await getCurrentUser();
    final now = DateTime.now();
    await _repository.addTemplate(AchievementTemplate(
      id: 'tpl_${now.microsecondsSinceEpoch}',
      name: draft.name.trim(),
      description: draft.description.trim(),
      icon: draft.icon,
      points: draft.points,
      createdById: user.id,
      createdByName: user.name,
      createdAt: now,
    ));
    notifyListeners();
  }

  /// Only the author can delete a base achievement. Achievements already
  /// sent keep their own copy of name, icon and points.
  Future<void> deleteTemplate(String templateId) async {
    final user = await getCurrentUser();
    final templates = await _repository.getTemplates();
    final template = templates.firstWhere((t) => t.id == templateId);
    if (template.createdById != user.id) {
      throw const SendAchievementException(
          SendAchievementError.notTemplateOwner);
    }
    await _repository.deleteTemplate(templateId);
    notifyListeners();
  }

  Future<SendAchievementOptions> getSendOptions() async {
    final user = await getCurrentUser();
    final users = await _repository.getUsers();
    final achievements = await _repository.getAchievements();
    return SendAchievementOptions(
      currentUser: user,
      colleagues: users
          .where((u) => u.companyId == user.companyId && u.id != user.id)
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name)),
      templates: await getTemplates(),
      sentPairs: {
        for (final a in achievements)
          if (a.awardedById == user.id && a.templateId != null)
            (a.templateId!, a.userId!)
      },
    );
  }

  /// Achievements the current user sent, newest first.
  Future<List<Achievement>> getSentAchievements() async {
    final user = await getCurrentUser();
    final achievements = await _repository.getAchievements();
    return achievements.where((a) => a.awardedById == user.id).toList()
      ..sort((a, b) => b.date!.compareTo(a.date!));
  }

  /// Sends a base achievement to a colleague of the same company. The same
  /// base achievement can be sent to the same colleague only once.
  Future<void> sendAchievement(SendAchievementRequest request) async {
    final options = await getSendOptions();
    final colleague = options.colleagues
        .where((u) => u.id == request.colleagueId)
        .firstOrNull;
    final template =
        options.templates.where((t) => t.id == request.templateId).firstOrNull;
    if (colleague == null) {
      throw const SendAchievementException(SendAchievementError.notAColleague);
    }
    if (template == null) {
      throw const SendAchievementException(
          SendAchievementError.templateNotFound);
    }
    if (options.alreadySent(template.id, colleague.id)) {
      throw SendAchievementException(SendAchievementError.alreadySent,
          templateName: template.name, colleagueName: colleague.name);
    }

    final company = await getCompany(colleague.companyId);
    final note = request.note?.trim();
    await _repository.addAchievement(Achievement(
      id: 'ach_sent_${DateTime.now().microsecondsSinceEpoch}',
      userId: colleague.id,
      name: template.name,
      description: template.description,
      icon: template.icon,
      points: template.points,
      company: company.name,
      date: DateTime.now(),
      verified: false,
      templateId: template.id,
      awardedById: options.currentUser.id,
      awardedByName: options.currentUser.name,
      note: (note == null || note.isEmpty) ? null : note,
    ));
    notifyListeners();
  }
}
