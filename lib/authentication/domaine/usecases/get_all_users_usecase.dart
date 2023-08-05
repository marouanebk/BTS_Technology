import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/authentication/domaine/repository/user_repository.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class GetAllUsersUseCase {
  final BaseUserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<Either<Failure, List<User>>> call() async {
    return await repository.getAllUsers();
  }
}
