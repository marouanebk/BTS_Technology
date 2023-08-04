import 'package:bts_technologie/logistiques/domaine/entities/to_do_entity.dart';

class ArticleModel extends Article {
  const ArticleModel({
    String? todoid,
    String? userid,
    required String todo,
    required String status,
  }) : super(todoid: todoid, userid: userid, todo: todo, status: status);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      todoid: json["_id"],
      userid: json["userid"],
      todo: json["todo"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": userid,
      "todo": todo,
      "status": status,
    };
  }
}
