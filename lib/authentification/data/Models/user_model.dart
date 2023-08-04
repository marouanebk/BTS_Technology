import 'package:bts_technologie/authentification/domaine/Entities/user.dart';

class UserModel extends User {
  const UserModel({
    String? id,
    String? fullname,
    required String username,
    required String password,
    String? role,
  }) : super(
            id: id,
            fullname: fullname,
            username: username,
            password: password,
            role: role);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
        password: json["password"],
        role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullname": fullname,
      "username": username,
      "password": password,
      "role": role
    };
  }
}
