import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserInfoUseCase {
  final BaseAccountRepository repository;

  GetUserInfoUseCase(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.getUserInfo();
  }
}
