import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/entreprise_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:dartz/dartz.dart';

class GetEntrepriseInfoUsecase {
  final BaseAccountRepository repository;

  GetEntrepriseInfoUsecase(this.repository);

  Future<Either<Failure, Entreprise>> call() async {
    return await repository.getEntrepriseInfo();
  }
}
