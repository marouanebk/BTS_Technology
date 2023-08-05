import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';

class GetArticlesUseCase {
  final BaseArticleRepository repository;

  GetArticlesUseCase(this.repository);

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getArticles();
  }
}
