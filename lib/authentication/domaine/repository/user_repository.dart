import 'package:dartz/dartz.dart';
import 'package:bts_technologie/authentication/data/models/user_model.dart';
import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/error/failure.dart';


abstract class BaseUserRepository {
  Future<Either<Failure, User>> loginUser(User user);

  Future<Either<Failure, User>> createUser(User user);

  Future<Either<Failure, bool>> logout();
  

    // Future<Either<Failure, List<UserModel>>> searchUsers(String id);





}
