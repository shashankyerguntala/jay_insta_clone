class UserEntity {
  final int id;
  final String username;
  final String email;
  final String role;
  final bool? hasRequestedModerator;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.hasRequestedModerator,
  });
}
