import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/user_stat_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:dartz/dartz.dart';

class GetClientsUseCase {
  final BaseAccountRepository repository;

  GetClientsUseCase(this.repository);

  Future<Either<Failure, List<UserStatEntity>>> call() async {
    return await repository.getClientsStats();
  }
}
