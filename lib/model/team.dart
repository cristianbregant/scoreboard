/// A group of people in a company, led by a manager.
///
/// Membership lives on the person (`UserProfile.teamId`): everyone is in
/// at most one team.
class Team {
  final String id;
  final String companyId;
  final String name;

  /// Sees the team's activity and proposes verified achievements for its
  /// members. Null while nobody leads the team.
  final String? managerId;

  const Team(
      {required this.id,
      required this.companyId,
      required this.name,
      this.managerId});

  /// [managerId] is cleared with an empty string, since null means
  /// "unchanged".
  Team copyWith({String? name, String? managerId}) => Team(
        id: id,
        companyId: companyId,
        name: name ?? this.name,
        managerId: managerId == null
            ? this.managerId
            : (managerId.isEmpty ? null : managerId),
      );

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'],
        companyId: json['company_id'],
        name: json['name'],
        managerId: json['manager_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_id': companyId,
        'name': name,
        'manager_id': managerId,
      };
}
