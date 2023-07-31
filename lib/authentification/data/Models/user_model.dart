import 'package:bts_technologie/authentification/domaine/Entities/user.dart';

class UserModel extends User {
  const UserModel(
      {String? id,
      required String fullname,
      required String email,
      required String password})
      : super(id: id, fullname: fullname, email: email, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullname": fullname,
      "email": email,
      "password": password
    };
  }
}
