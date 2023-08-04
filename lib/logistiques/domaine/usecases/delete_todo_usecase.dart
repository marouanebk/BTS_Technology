import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/logistiques/domaine/entities/to_do_entity.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';

class DeleteArticleUseCase {
  final BaseArticleRepository repository;

  DeleteArticleUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Article article) async {
    return await repository.deleteArticle(article);
  }
}
