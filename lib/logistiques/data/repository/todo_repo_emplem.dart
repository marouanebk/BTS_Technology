import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/logistiques/data/datasource/article_datasource.dart';
import 'package:bts_technologie/logistiques/domaine/entities/to_do_entity.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';

class ArticleRepository implements BaseArticleRepository {
  final BaseArticleRemoteDateSource baseArticleRemoteDateSource;

  ArticleRepository(this.baseArticleRemoteDateSource);

  @override
  Future<Either<Failure, Unit>> addArticle(Article article) async {
    final ArticleModel articleModel = ArticleModel(
      userid: article.userid,
      todo: article.todo,
      status: article.status,
    );
    

    try {
      final result = await baseArticleRemoteDateSource.addArticle(articleModel);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteArticle(Article article) async {
    try {
      final result = await baseArticleRemoteDateSource.deleteArticle(article);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> editArticle(Article article) async {
    try {
      final result = await baseArticleRemoteDateSource.editArticle(article);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getDoneArticle() async {
    try {
      final result = await baseArticleRemoteDateSource.getDoneArticle();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getUnDoneArticle() async {
    try {
      final result = await baseArticleRemoteDateSource.getUnDoneArticle();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
