import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/finances/domaine/entities/cashflow_entity.dart';
import 'package:bts_technologie/finances/domaine/repository/base_finance_repo.dart';
import 'package:dartz/dartz.dart';


class GetCashFlowUseCase {
  final BaseFinanceRepository repository;

  GetCashFlowUseCase(this.repository);

  Future<Either<Failure, CashFlow>> call() async {
    return await repository.getCashFlow();
  }
}
