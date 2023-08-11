import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';

class UserModel extends User {
  const UserModel({
    String? id,
    String? fullname,
    required String username,
    String? password,
    String? role,
    List<String?>? pages,
    List<String?>? commandeTypes,
  }) : super(
          id: id,
          fullname: fullname,
          username: username,
          password: password,
          role: role,
          pages: pages,
          commandeTypes: commandeTypes,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      fullname: json["fullName"],
      username: json["username"],
      password: json["password"],
      role: json['role'],
      pages: List<String?>.from(json["pages"] ?? []),
      commandeTypes: List<String?>.from(json["commandeTypes"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullname,
      "username": username,
      "password": password,
      "role": role,
      "pages": pages,
      "commandeTypes": commandeTypes,
    };
  }
}
