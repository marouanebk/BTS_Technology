import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/domaine/Repository/base_command_repo.dart';
import 'package:dartz/dartz.dart';

class GetCommandesUseCase {
  final BaseCommandRepository repository;

  GetCommandesUseCase(this.repository);

  Future<Either<Failure, List<Command>>> call() async {
    return await repository.getCommandes();
  }
}
