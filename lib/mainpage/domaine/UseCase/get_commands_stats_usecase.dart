import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/command_stats_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:dartz/dartz.dart';

class GetCommandsStatsUseCase {
  final BaseAccountRepository repository;

  GetCommandsStatsUseCase(this.repository);

  Future<Either<Failure, List<CommandStatsEntity>>> call(int? month , int year) async {
    return await repository.getCommandStats();
  }
}
