import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';

class PageModel extends FacePage {
  const PageModel(
      {String? id,
      required String pageName,
      int? numberOfCommands,
      num? totalMoneyMade,
      String? admin})
      : super(
          pageName: pageName,
          id: id,
          totalMoneyMade: totalMoneyMade,
          numberOfCommands: numberOfCommands,
          admin: admin,
        );

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      pageName: json["name"],
      id: json["_id"],
      numberOfCommands: json["numberOfCommands"],
      totalMoneyMade: json["totalMoneyMade"],
      admin: json["admin"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": pageName,
    };
  }
}
