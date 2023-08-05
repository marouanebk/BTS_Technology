import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';

class EditArticleUseCase {
  final BaseArticleRepository repository;

  EditArticleUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Article article) async {
    return await repository.editArticle(article);
  }
}
