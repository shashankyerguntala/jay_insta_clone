class ModeratorRequestEntity {
  final int id;
  final String status;
  final String username;
  final DateTime requestedAt;
  final int? reviewedBy;

  ModeratorRequestEntity({
    required this.id,
    required this.status,
    required this.username,
    required this.requestedAt,
    required this.reviewedBy,
  });

  ModeratorRequestEntity copyWith({
    int? id,
    String? status,
    String? username,
    DateTime? requestedAt,
    int? reviewedBy,
  }) {
    return ModeratorRequestEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      username: username ?? this.username,
      requestedAt: requestedAt ?? this.requestedAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
    );
  }
}
