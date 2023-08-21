import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/data/Models/livreur_model.dart';
import 'package:bts_technologie/mainpage/data/dataSource/account_datasource.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/command_stats_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/entreprise_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/user_stat_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:dartz/dartz.dart';

class AccountRepository implements BaseAccountRepository {
  final BaseAccountRemoteDateSource baseAccountRemoteDateSource;

  AccountRepository(this.baseAccountRemoteDateSource);

  @override
  Future<Either<Failure, List<FacePage>>> getPages() async {
    try {
      final result = await baseAccountRemoteDateSource.getPages();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<LivreurModel>>> getLivreurs() async {
    try {
      final result = await baseAccountRemoteDateSource.getLivreurs();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Entreprise>> getEntrepriseInfo() async {
    try {
      final result = await baseAccountRemoteDateSource.getEntrepriseInfo();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<CommandStatsEntity>>> getCommandStats() async {
    try {
      final result = await baseAccountRemoteDateSource.getCommandStats();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<UserStatEntity>>> getUsersStats() async {
    try {
      final result = await baseAccountRemoteDateSource.getUsersStats();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> getUserInfo() async {
    try {
      final result = await baseAccountRemoteDateSource.getUserInfo();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<UserStatEntity>>> getClientsStats() async {
    try {
      final result = await baseAccountRemoteDateSource.getClientsStats();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
