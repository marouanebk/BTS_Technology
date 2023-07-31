import 'package:bts_technologie/authentification/data/Models/user_model.dart';
import 'package:bts_technologie/authentification/data/dataSource/user_datasource.dart';
import 'package:bts_technologie/authentification/domaine/Entities/user.dart';
import 'package:bts_technologie/authentification/domaine/repository/user_repository.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class UserRepository implements BaseUserRepository {
  final BaseUserRemoteDateSource baseUserRemoteDateSource;

  UserRepository(this.baseUserRemoteDateSource);

  @override
  Future<Either<Failure, User>> signupUser(User user) async {
    final UserModel userModel = UserModel(
      id: user.id,
      fullname: user.fullname,
      email: user.email,
      password: user.password,
    );

    try {
      final result = await baseUserRemoteDateSource.signupUser(userModel);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> loginUser(User user) async {
    final UserModel userModel = UserModel(
      id: user.id,
      fullname: user.fullname,
      email: user.email,
      password: user.password,
    );

    try {
      final result = await baseUserRemoteDateSource.loginUser(userModel);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
