import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/finances/data/datasource/finance_datasource.dart';
import 'package:bts_technologie/finances/domaine/entities/cashflow_entity.dart';
import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';
import 'package:bts_technologie/finances/domaine/repository/base_finance_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';

class FinanceRepository implements BaseFinanceRepository {
  final BaseFinanceRemoteDateSource baseFinanceRemoteDateSource;

  FinanceRepository(this.baseFinanceRemoteDateSource);

  @override
  Future<Either<Failure, List<FinanceEntity>>> getFinances() async {
    try {
      final result = await baseFinanceRemoteDateSource.getFinances();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addArticle(Article article) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CashFlow>> getCashFlow() async {
    try {
      final result = await baseFinanceRemoteDateSource.getCashFlow();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
