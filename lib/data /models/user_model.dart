import 'package:jay_insta_clone/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.email,
    required super.role,
    required super.id,
    super.hasRequestedModerator,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? "",
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      role: json["role"] ?? "",
      hasRequestedModerator: json["hasRequestedModerator"],
    );
  }
  UserEntity toEntity() {
    return UserEntity(username: username, email: email, role: role, id: id);
  }
}
