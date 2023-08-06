import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';

class PageModel extends FacePage {
  const PageModel({
    String? id,
    required String pageName,
  }) : super(
          pageName: pageName,
          id: id,
        );

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      pageName: json["name"],
      id: json["_id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": pageName,
    };
  }
}
