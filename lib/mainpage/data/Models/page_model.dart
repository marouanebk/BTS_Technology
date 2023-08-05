import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';

class PageModel extends FacePage {
  const PageModel({
    required String pageName,
  }) : super(
          pageName: pageName,
        );

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      pageName: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": pageName,
    };
  }
}
