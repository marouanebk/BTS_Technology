import 'dart:developer';

import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';

class CommandModel extends Command {
  // final Map<String, dynamic> data; // Store dynamic data for each date
  // final String? date;
  const CommandModel({
    String? date,
    String? id,
    num? comNumber,
    String? noteClient,
    List<Article?>? articles,
    String? user,
    String? status,
    required String nomClient,
    required String adresse,
    required String page,
    required num phoneNumber,
    required num sommePaid,
    //
    List<CommandArticle?> articleList = const [],
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
          date: date,
          articleList: articleList,
        );

  static List<CommandModel> fromJsonList(Map<String, dynamic> json) {
    final dateKeys = json.keys.toList();

    final List<CommandModel> commandModels = [];

    dateKeys.forEach((dateKey) {
      final dateData = json[dateKey];

      dateData.forEach((data) {
        final commandModel = CommandModel(
          date: dateKey,
          id: data["_id"],
          comNumber: data["comNumber"],
          noteClient: data["noteClient"],
          sommePaid: data["sommePaid"],
          user: data["user"]["username"],
          nomClient: data["nomClient"],
          adresse: data["adresse"],
          page: data["page"]["name"],
          phoneNumber: data["phoneNumber"],
          status: data["status"],
        );

        // Add the CommandModel instance to the list
        commandModels.add(commandModel);
      });
    });

    return commandModels;
  }

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
        id: json["_id"],
        comNumber: json["comNumber"],
        noteClient: json["noteClient"],
        // articles: json["articles"],
        sommePaid: json["sommePaid"],
        user: json["user"],
        nomClient: json["nomClient"],
        adresse: json["adresse"],
        page: json["page"]["name"],
        phoneNumber: json["phoneNumber"],
        status: json["status"]);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> articles = [];
    if (articleList != null) {
      articles = articleList.map((variant) {
        return {
          'articleId': variant!.articleId,
          'variantId': variant.variantId,
          'commandType': variant.commandType,
          'quantity': variant.quantity,
          'unityPrice': variant.unityPrice,
        };
      }).toList();
    }
    return {
      "sommePaid": sommePaid,
      "user": user,
      "nomClient": nomClient,
      "adresse": adresse,
      "phoneNumber": phoneNumber,
      "page": page,
      "status": status,
      "articles": articles,
    };
  }

  // @override
  // String toString() {
  //   return 'CommandModel($date, $id, $comNumber, $noteClient, $articles, $nomClient, $user, $adresse, $phoneNumber, $sommePaid, $page, $status , $articles)';
  // }
}
