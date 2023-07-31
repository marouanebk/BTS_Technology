import 'package:bts_technologie/authentification/domaine/Entities/user.dart';
import 'package:bts_technologie/authentification/domaine/Repository/user_repository.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final BaseUserRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, User>> call(User user) async {
    return await repository.signupUser(user);
  }
}
