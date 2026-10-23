enum AdminError {
  notAdmin,
  missingFields,
  invalidPoints,
  alreadyOwned,
  requestPending,
  invalidUrl,
  notFound,
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
