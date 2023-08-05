import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/data/Models/livreur_model.dart';
import 'package:bts_technologie/mainpage/data/dataSource/account_datasource.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
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
}
