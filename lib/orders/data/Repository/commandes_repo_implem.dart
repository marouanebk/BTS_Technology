import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:bts_technologie/orders/data/dataSource/commades_datasource.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/domaine/Repository/base_command_repo.dart';
import 'package:dartz/dartz.dart';

class CommandesRepository implements BaseCommandRepository {
  final BaseCommandRemoteDatasource baseCommandRemoteDatasource;

  CommandesRepository(this.baseCommandRemoteDatasource);

  @override
  Future<Either<Failure, List<Command>>> getCommandes() async {
    try {
      final result = await baseCommandRemoteDatasource.getCommandes();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
