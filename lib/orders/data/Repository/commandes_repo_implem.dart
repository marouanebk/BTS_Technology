import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
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

  @override
  Future<Either<Failure, Unit>> createCommand(Command command) async {
    final CommandModel articleModel = CommandModel(
      adresse: command.adresse,
      nomClient: command.nomClient,
      phoneNumber: command.phoneNumber,
      noteClient: command.noteClient,
      page: command.page,
      prixSoutraitant: command.prixSoutraitant,
      // page: article.page,
      status: command.status,
      sommePaid: command.sommePaid,
      articleList: command.articleList,
    );

    try {
      final result =
          await baseCommandRemoteDatasource.createCommand(articleModel);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
