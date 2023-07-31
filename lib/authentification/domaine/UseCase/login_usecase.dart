import 'package:bts_technologie/authentification/domaine/Entities/user.dart';
import 'package:bts_technologie/authentification/domaine/Repository/user_repository.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final BaseUserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(User user) async {
    return await repository.loginUser(user);
  }
}
