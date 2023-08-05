import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';

class CommandModel extends Command {
  const CommandModel({
    String? id,
    num? comNumber,
    String? noteClient,
    List<Article?>? articles,
    required String user,
    required String nomClient,
    required String adresse,
    required String page,
    required num phoneNumber,
    required num sommePaid,
    required String status,
  }) : super(
          id: id,
          comNumber: comNumber,
          noteClient: noteClient,
          articles: articles,
          user: user,
          nomClient: nomClient,
          adresse: adresse,
          page: page,
          phoneNumber: phoneNumber,
          sommePaid: sommePaid,
          status: status,
        );

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
        id: json["_id"],
        comNumber: json["comNumber"],
        noteClient: json["noteClient"],
        articles: json["articles"],
        sommePaid: json["sommePaid"],
        user: json["user"],
        nomClient: json["nomClient"],
        adresse: json["adresse"],
        page: json["page"],
        phoneNumber: json["phoneNumber"],
        status: json["status"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "sommePaid": sommePaid,
      "user": user,
      "nomClient": nomClient,
      "adresse": adresse,
      "phoneNumber": phoneNumber,
      "page": page,
      "status": status,
    };
  }
}
