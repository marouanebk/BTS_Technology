import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:dartz/dartz.dart';

class GetLivreurUseCase {
  final BaseAccountRepository repository;

  GetLivreurUseCase(this.repository);

  Future<Either<Failure, List<Livreur>>> call() async {
    return await repository.getLivreurs();
  }
}
