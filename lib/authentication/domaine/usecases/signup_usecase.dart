import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/authentication/domaine/repository/user_repository.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class CreateUserUseCase {
  final BaseUserRepository repository;

  CreateUserUseCase(this.repository);

  Future<Either<Failure, User>> call(User user) async {
    return await repository.createUser(user);
  }
}

