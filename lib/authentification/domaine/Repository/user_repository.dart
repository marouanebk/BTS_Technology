import 'package:bts_technologie/authentification/domaine/Entities/user.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUserRepository {
  Future<Either<Failure, User>> loginUser(User user);

  Future<Either<Failure, User>> signupUser(User user);
}
