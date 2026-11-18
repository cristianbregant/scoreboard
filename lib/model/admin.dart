enum AdminError {
  notAdmin,
  missingFields,
  invalidPoints,
  alreadyOwned,
  requestPending,
  invalidUrl,
  notFound,
  invalidDates,
  seasonOverlap,
  notManager,
  notInTeam,
  invalidEmail,

  /// The invited email already has an account.
  alreadyMember,

  /// Revoking the admin role of a company's only admin.
  lastAdmin,

  /// The invitation email could not be sent.
  emailNotSent,

  /// An import beyond `ScoreboardRepository.maxBulkInvites` people.
  tooManyInvites,

  /// Single sign-on settings: not a Microsoft tenant id, not a domain, or
  /// already used by another company.
  invalidSsoTenant,
  invalidSsoDomain,
  ssoInUse,

  /// Chat integrations: not a Teams or Slack webhook, the service refused
  /// the message, the channel isn't connected, or the local mock can't
  /// reach the service.
  invalidWebhook,
  webhookFailed,
  notConfigured,
  needsBackend,
}

/// Carries an [AdminError] code; the UI turns it into localized text.
class AdminException implements Exception {
  final AdminError error;

  const AdminException(this.error);

  @override
  String toString() => 'AdminException($error)';
}

/// Outcome of issuing one catalog achievement to several people.
class IssueResult {
  final int issued;

  /// People who already had the achievement.
  final int skipped;

  const IssueResult({required this.issued, required this.skipped});
}
