import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:dartz/dartz.dart';


abstract class BaseArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
  Future<Either<Failure, List<Article>>> getUnDoneArticle();

  Future<Either<Failure, Unit>> addArticle(Article article);
  Future<Either<Failure, Unit>> deleteArticle(Article article);
  Future<Either<Failure, Unit>> editArticle(Article article);
}
