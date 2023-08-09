import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/finances/domaine/entities/cashflow_entity.dart';
import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:dartz/dartz.dart';


abstract class BaseFinanceRepository {
  Future<Either<Failure, List<FinanceEntity>>> getFinances();

  Future<Either<Failure, Unit>> addArticle(Article article);
  Future<Either<Failure, CashFlow>> getCashFlow();
  // Future<Either<Failure, Unit>> deleteArticle(Article article);
  // Future<Either<Failure, Unit>> editArticle(Article article);
}
