import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';
import 'package:bts_technologie/finances/domaine/repository/base_finance_repo.dart';
import 'package:dartz/dartz.dart';


class GetFinancesUseCase {
  final BaseFinanceRepository repository;

  GetFinancesUseCase(this.repository);

  Future<Either<Failure, List<FinanceEntity>>> call() async {
    return await repository.getFinances();
  }
}
