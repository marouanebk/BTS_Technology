import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/user_stat_entity.dart';

class UserStatModel extends UserStatEntity {
  const UserStatModel({
    String? id,
    String? fullname,
    String? username,
    required num totalMoneyMade,
    required num numberOfCommands,
  }) : super(
          id: id,
          fullname: fullname,
          username: username,
          totalMoneyMade: totalMoneyMade,
          numberOfCommands: numberOfCommands,
        );

  factory UserStatModel.fromJson(Map<String, dynamic> json) {
    return UserStatModel(
      id: json["_id"],
      fullname: json["fullName"],
      username: json["username"],
      numberOfCommands: json["numberOfCommands"],
      totalMoneyMade: json["totalMoneyMade"],
    );
  }
}
