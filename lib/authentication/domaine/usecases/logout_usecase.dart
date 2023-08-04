import 'package:bts_technologie/authentication/domaine/repository/user_repository.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class LogOutUseCase {
  final BaseUserRepository repository;

  LogOutUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.logout();
  }
}

