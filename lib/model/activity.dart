/// What an admin (or a manager) did, for the company's activity log.
enum ActivityType {
  catalogCreated,
  catalogUpdated,
  catalogArchived,
  catalogRestored,
  achievementsIssued,
  requestApproved,
  requestRejected,
  nominationSubmitted,
  teamCreated,
  teamUpdated,
  teamDeleted,
  memberMoved,
  seasonCreated,
  seasonUpdated,
  seasonDeleted,
  brandUpdated,
  anniversariesUpdated,
  reportExported,
  personalDataExported,
}

/// One line of the activity log. It keeps names as they were at the time,
/// so renaming or deleting something doesn't rewrite history.
class ActivityEntry {
  final String id;
  final String companyId;
  final String actorId;
  final String actorName;
  final ActivityType type;
  final DateTime createdAt;

  /// What the action was about: an achievement, a team, a person…
  final String? subject;

  /// A second name, e.g. the recipient of an approved request.
  final String? target;

  /// How many, e.g. people an achievement was issued to.
  final int? count;

  const ActivityEntry(
      {required this.id,
      required this.companyId,
      required this.actorId,
      required this.actorName,
      required this.type,
      required this.createdAt,
      this.subject,
      this.target,
      this.count});

  factory ActivityEntry.fromJson(Map<String, dynamic> json) => ActivityEntry(
        id: json['id'],
        companyId: json['company_id'],
        actorId: json['actor_id'],
        actorName: json['actor_name'],
        type: ActivityType.values.byName(json['type']),
        createdAt: DateTime.parse(json['created_at']),
        subject: json['subject'],
        target: json['target'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_id': companyId,
        'actor_id': actorId,
        'actor_name': actorName,
        'type': type.name,
        'created_at': createdAt.toIso8601String(),
        'subject': subject,
        'target': target,
        'count': count,
      };
}
