import 'package:jay_insta_clone/domain/entity/user_entity.dart';

class UserModel extends User {
  UserModel({
    required super.username,
    required super.email,
    required super.role,
    required super.isModerator,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      role: json["role"] ?? "",
      isModerator: json["isModerator"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "role": role,
      "isModerator": isModerator,
    };
  }
}
