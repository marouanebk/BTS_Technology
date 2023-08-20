import 'dart:io';

import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class Command extends Equatable {
  final String? id;
  final num? comNumber;
  final String? noteClient;
  final List<Article?>? articles;
  final String? date;
  final String? user;
  final String? status;
  final num? prixSoutraitant;
  final String? livreur;
  final String? createdAt;

  final String? page;
  final String nomClient;
  final String adresse;
  final num phoneNumber;
  final num sommePaid;
  final List<CommandArticle?> articleList;
  final List<Map<String, dynamic>>? statusUpdates;
  

  const Command({
    this.id,
    this.comNumber,
    this.noteClient,
    this.articles,
    this.date,
    this.user,
    this.status,
    this.prixSoutraitant,
    this.page,
    this.livreur,
    this.createdAt,
    this.statusUpdates,
    required this.nomClient,
    required this.adresse,
    required this.phoneNumber,
    required this.sommePaid,
    required this.articleList,
  });

  @override
  List<Object?> get props => [
        id,
        comNumber,
        noteClient,
        articles,
        nomClient,
        prixSoutraitant,
        user,
        adresse,
        phoneNumber,
        sommePaid,
        page,
        status,
        articleList,
        livreur
      ];
}

class CommandArticle extends Equatable {
  final String? id;
  final String? articleName;
  final String? taille;
  final String? colour;
  final String? family;
  final String? commandType;
  final String? articleId;
  final String variantId;
  final int quantity;
  final num unityPrice;
  final List<File>? files;
  final List<String>? photos;
  final List<String>? deletedPhotos;

  const CommandArticle({
    this.id,
    this.articleName,
    this.taille,
    this.colour,
    this.family,
    this.commandType,
    this.files,
    this.articleId,
    this.photos,
    this.deletedPhotos,

    // required this.articleId,
    required this.variantId,
    required this.quantity,
    required this.unityPrice,
  });
  @override
  List<Object?> get props => [
        id,
        articleName,
        taille,
        colour,
        family,
        articleId,
        variantId,
        commandType,
        quantity,
        unityPrice,
        photos,
        deletedPhotos,
      ];
}
