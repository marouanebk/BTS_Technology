import 'dart:developer';

import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';

class UserModel extends User {
  const UserModel({
    String? id,
    String? fullname,
    required String username,
    String? password,
    String? role,
    List<String?>? pages,
    List<String?>? commandeTypes,
    List<FacePage>? populatedpages,
  }) : super(
          id: id,
          fullname: fullname,
          username: username,
          password: password,
          role: role,
          pages: pages,
          commandeTypes: commandeTypes,
          populatedpages:populatedpages,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<FacePage> populatedPages = [];

    if (json['populatedPages'] is List) {
      List<dynamic> populatedPagesJson = json['populatedPages'];
      if (populatedPagesJson.isNotEmpty) {
        populatedPages = populatedPagesJson.map<FacePage>((pageJson) {
          return FacePage(
            id: pageJson["_id"],
            pageName: pageJson["name"],
            numberOfCommands: pageJson["numberOfCommands"],
            totalMoneyMade: pageJson["totalMoneyMade"],
          );
        }).toList();
      }
    }

    UserModel userModel = UserModel(
      id: json["_id"],
      fullname: json["fullName"],
      username: json["username"],
      password: json["password"],
      role: json['role'],
      populatedpages: populatedPages,
      pages: List<String?>.from(json["pages"] ?? []),
      commandeTypes: List<String?>.from(json["commandeTypes"] ?? []),
    );

    // Return the already populated userModel instance
    return userModel;
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
