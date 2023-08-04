import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/logistiques/domaine/entities/to_do_entity.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';

class GetDoneArticleUseCase {
  final BaseArticleRepository repository;

  GetDoneArticleUseCase(this.repository);

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getDoneArticle();
  }
}
