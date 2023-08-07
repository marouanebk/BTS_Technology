import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class Command extends Equatable {
  final String? id;
  final num? comNumber;
  final String? noteClient;
  final List<Article?>? articles;
  final String? date;
  final String? user;
  final String ?status;

  final String page;
  final String nomClient;
  final String adresse;
  final num phoneNumber;
  final num sommePaid;
  final List<CommandArticle?> articleList;

  const Command({
    this.id,
    this.comNumber,
    this.noteClient,
    this.articles,
    this.date,
    this.user,
    this.status,
    required this.nomClient,
    required this.adresse,
    required this.phoneNumber,
    required this.sommePaid,
    required this.page,
    required this.articleList,
  });

  @override
  List<Object?> get props => [
        id,
        comNumber,
        noteClient,
        articles,
        nomClient,
        user,
        adresse,
        phoneNumber,
        sommePaid,
        page,
        status,
        articleList
      ];
}

class CommandArticle extends Equatable {
  final String? id;
  final String articleId;
  final String variantId;
  final String commandType;
  final int quantity;
  final num unityPrice;

  const CommandArticle({
    this.id,
    required this.articleId,
    required this.variantId,
    required this.commandType,
    required this.quantity,
    required this.unityPrice,
  });
  @override
  List<Object?> get props =>
      [id, articleId, variantId, commandType, quantity, unityPrice];
}
