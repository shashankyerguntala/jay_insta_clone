enum UserRole { author, moderator, admin, superAdmin }

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.author:
        return "AUTHOR";
      case UserRole.moderator:
        return "MODERATOR";
      case UserRole.admin:
        return "ADMIN";
      case UserRole.superAdmin:
        return "SUPER_ADMIN";
    }
  }

  static UserRole fromString(String role) {
    switch (role.toUpperCase()) {
      case "AUTHOR":
        return UserRole.author;
      case "MODERATOR":
        return UserRole.moderator;
      case "ADMIN":
        return UserRole.admin;
      case "SUPER_ADMIN":
        return UserRole.superAdmin;
      default:
        return UserRole.author;
    }
  }
}
