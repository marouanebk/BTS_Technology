import 'dart:developer';

import 'package:bts_technologie/authentication/data/datasource/user_datasource.dart';
import 'package:bts_technologie/authentication/data/models/user_model.dart';
import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/authentication/domaine/repository/user_repository.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class UserRepository extends BaseUserRepository {
  final BaseUserRemoteDateSource baseUserRemoteDateSource;

  UserRepository(this.baseUserRemoteDateSource);

  @override
  Future<Either<Failure, User>> createUser(user) async {
    
    final UserModel userModel = UserModel(
      fullname: user.fullname,
      username: user.username,
      password: user.password,
      role: user.role,
      pages: user.pages,
      commandeTypes: user.commandeTypes,
    );

    try {
      final result = await baseUserRemoteDateSource.createUser(userModel);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> loginUser(user) async {
    final UserModel userModel = UserModel(
      username: user.username,
      password: user.password,
    );

    try {
      final result = await baseUserRemoteDateSource.loginUser(userModel);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await baseUserRemoteDateSource.logOutUser();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final result = await baseUserRemoteDateSource.getAllUsers();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
