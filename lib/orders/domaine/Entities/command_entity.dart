import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class Command extends Equatable {
  final String? id;
  final num? comNumber;
  final String? noteClient;
  final List<Article?>? articles;
  final String? date;

  final String user;
  final String page;
  final String nomClient;
  final String adresse;
  final num phoneNumber;
  final num sommePaid;
  final String status;

  const Command({
    this.id,
    this.comNumber,
    this.noteClient,
    this.articles,
    this.date,
    required this.nomClient,
    required this.user,
    required this.adresse,
    required this.phoneNumber,
    required this.sommePaid,
    required this.page,
    required this.status,
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
        status
      ];
}
