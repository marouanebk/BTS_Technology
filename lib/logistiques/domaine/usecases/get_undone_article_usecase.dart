import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';

class GetUnDoneArticleUseCase {
  final BaseArticleRepository repository;

  GetUnDoneArticleUseCase(this.repository);

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getUnDoneArticle();
  }
}
