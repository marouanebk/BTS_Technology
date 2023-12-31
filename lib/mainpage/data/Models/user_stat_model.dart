import 'package:bts_technologie/mainpage/domaine/Entities/user_stat_entity.dart';

class UserStatModel extends UserStatEntity {
  const UserStatModel({
    String? id,
    String? fullname,
    String? username,
    String? phoneNumber,
    required num totalMoneyMade,
    required num numberOfCommands,
  }) : super(
          id: id,
          fullname: fullname,
          username: username,
          totalMoneyMade: totalMoneyMade,
          numberOfCommands: numberOfCommands,
          phonenumber: phoneNumber,
        );

  factory UserStatModel.fromJson(Map<String, dynamic> json) {
    return UserStatModel(
      id: json["_id"],
      fullname: json["fullName"],
      username: json["username"],
      numberOfCommands: json["numberOfCommands"],
      totalMoneyMade: json["totalMoneyMade"],
      phoneNumber: json["phoneNumber"]
    );
  }
}
