
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
    num? prixSoutraitant,
    String? page,
    String? livreur,
    List<Map<String, dynamic>>? statusUpdates,
    String? createdAt,
    required String nomClient,
    required String adresse,
    required num phoneNumber,
    required num sommePaid,

    //
    List<CommandArticle?> articleList = const [],
  }) : super(
            id: id,
            comNumber: comNumber,
            noteClient: noteClient,
            articles: articles,
            prixSoutraitant: prixSoutraitant,
            user: user,
            nomClient: nomClient,
            adresse: adresse,
            page: page,
            phoneNumber: phoneNumber,
            sommePaid: sommePaid,
            status: status,
            date: date,
            articleList: articleList,
            livreur: livreur,
            createdAt: createdAt,
            statusUpdates: statusUpdates);

  static List<CommandModel> fromJsonList(Map<String, dynamic> json) {
    final dateKeys = json.keys.toList();

    final List<CommandModel> commandModels = [];

    for (var dateKey in dateKeys) {
      final dateData = json[dateKey];

      dateData.forEach((data) {
        var articleList = data['articles'] as List<dynamic>?;
        List<CommandArticle> variants = [];
        if (articleList != null) {
          variants = articleList.map((variantJson) {
            return CommandArticle(
              // articleId: variantJson['_id'],
              articleId: variantJson['articleId'],

              variantId: variantJson['variantID'],
              commandType: variantJson['commandType'],
              unityPrice: variantJson['unityPrice'],
              colour: variantJson['colour'],
              taille: variantJson['taille'],
              quantity: variantJson['quantity'],
              family: variantJson['family'],
              articleName: variantJson['articleName'],
              photos: List<String>.from(variantJson["photos"] ?? []),
            );
          }).toList();
        }

        String? page;
        String? livreur;
        if (data["page"] != null) page = data["page"]["_id"];
        if (data["livreur"] != null) livreur = data["livreur"]["name"];
        final commandModel = CommandModel(
          date: dateKey,
          id: data["_id"],
          comNumber: data["comNumber"],
          noteClient: data["noteClient"],
          sommePaid: data["sommePaid"],
          prixSoutraitant: data["sousTraitance"],
          user: data["user"]["username"],
          nomClient: data["nomClient"],
          adresse: data["adresse"],
          page: page,
          phoneNumber: data["phoneNumber"],
          status: data["status"],
          articleList: variants,
          livreur: livreur,
          // livreur: data["livreur"]["name"],
        );

        // Add the CommandModel instance to the list
        commandModels.add(commandModel);
      });
    }

    return commandModels;
  }

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    var articleList = json['articles'] as List<dynamic>?;

    List<CommandArticle> variants = [];

    if (articleList != null) {
      variants = articleList.map((variantJson) {
        return CommandArticle(
          // articleId: variantJson['_id'],
          articleId: variantJson['articleId'],

          variantId: variantJson['variantID'],
          commandType: variantJson['commandType'],
          unityPrice: variantJson['unityPrice'],
          colour: variantJson['colour'],
          taille: variantJson['taille'],
          quantity: variantJson['quantity'],
          family: variantJson['family'],
          articleName: variantJson['articleName'],
        );
      }).toList();
    }
    String? page;
    String? livreur;
    if (json["page"] != null) page = json["page"]["name"];
    if (json["livreur"] != null) livreur = json["livreur"]["name"];

    List<Map<String, dynamic>> statusUpdates = [];
    if (json['statusUpdates'] != null) {
      statusUpdates = (json['statusUpdates'] as List<dynamic>)
          .map((updateJson) => {
                'user': updateJson['user'],
                'status': updateJson['status'],
                '_id': updateJson['_id'],
                'timestamp': updateJson['timestamp'],
              })
          .toList();
    }

    return CommandModel(
      id: json["_id"],
      comNumber: json["comNumber"],
      noteClient: json["noteClient"],
      sommePaid: json["sommePaid"],
      prixSoutraitant: json["sousTraitance"],
      user: json["user"]["username"],
      nomClient: json["nomClient"],
      adresse: json["adresse"],
      page: page,
      phoneNumber: json["phoneNumber"],
      status: json["status"],
      articleList: variants,
      livreur: livreur,
      createdAt: json["createdAt"],
      statusUpdates: statusUpdates,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> articles = [];
    articles = articleList.map((variant) {
      return {
        'articleId': variant!.articleId,
        'variantId': variant.variantId,
        'commandType': variant.commandType,
        'quantity': variant.quantity,
        'unityPrice': variant.unityPrice,
        'photos': variant.photos,
      };
    }).toList();

    return {
      "sommePaid": sommePaid,
      "user": user,
      "nomClient": nomClient,
      "adresse": adresse,
      "phoneNumber": phoneNumber,
      "page": page,
      "status": status,
      "articles": articles,
      "noteClient": noteClient,
      "livreur": livreur,
      "prixSoutraitant": prixSoutraitant,
    };
  }

  // @override
  // String toString() {
  //   return 'CommandModel($date, $id, $comNumber, $noteClient, $articles, $nomClient, $user, $adresse, $phoneNumber, $sommePaid, $page, $status , $articles)';
  // }
}
