import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:dartz/dartz.dart';


abstract class BaseCommandRepository {
  Future<Either<Failure, List<Command>>> getCommandes();
  // Future<Either<Failure, List<Article>>> getUnDoneArticle();

  // Future<Either<Failure, Unit>> addArticle(Article article);
  // Future<Either<Failure, Unit>> deleteArticle(Article article);
  // Future<Either<Failure, Unit>> editArticle(Article article);
}
