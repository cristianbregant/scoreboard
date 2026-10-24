enum RequestStatus { pending, approved, rejected }

/// A member asking the company to issue a catalog achievement.
class VerificationRequest {
  final String id;
  final String userId;
  final String companyId;
  final String catalogId;
  final String message;
  final String? evidenceUrl;
  final RequestStatus status;
  final DateTime createdAt;
  final DateTime? decidedAt;
  final String? decidedById;
  final String? rejectionReason;

  /// The manager who proposed it for a member of their team; null when the
  /// member asked for it.
  final String? nominatedById;

  const VerificationRequest(
      {required this.id,
      required this.userId,
      required this.companyId,
      required this.catalogId,
      required this.message,
      this.evidenceUrl,
      this.status = RequestStatus.pending,
      required this.createdAt,
      this.decidedAt,
      this.decidedById,
      this.rejectionReason,
      this.nominatedById});

  VerificationRequest decide(RequestStatus status,
      {required String deciderId, String? reason}) {
    return VerificationRequest(
      id: id,
      userId: userId,
      companyId: companyId,
      catalogId: catalogId,
      message: message,
      evidenceUrl: evidenceUrl,
      status: status,
      createdAt: createdAt,
      decidedAt: DateTime.now(),
      decidedById: deciderId,
      rejectionReason: reason,
      nominatedById: nominatedById,
    );
  }

  factory VerificationRequest.fromJson(Map<String, dynamic> json) {
    return VerificationRequest(
      id: json['id'],
      userId: json['user_id'],
      companyId: json['company_id'],
      catalogId: json['catalog_id'],
      message: json['message'],
      evidenceUrl: json['evidence_url'],
      status: RequestStatus.values.byName(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      decidedAt: json['decided_at'] != null
          ? DateTime.parse(json['decided_at'])
          : null,
      decidedById: json['decided_by_id'],
      rejectionReason: json['rejection_reason'],
      nominatedById: json['nominated_by_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'company_id': companyId,
        'catalog_id': catalogId,
        'message': message,
        'evidence_url': evidenceUrl,
        'status': status.name,
        'created_at': createdAt.toIso8601String(),
        'decided_at': decidedAt?.toIso8601String(),
        'decided_by_id': decidedById,
        'rejection_reason': rejectionReason,
        'nominated_by_id': nominatedById,
      };
}
