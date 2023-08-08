import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/domaine/Repository/base_command_repo.dart';
import 'package:dartz/dartz.dart';

class EditCommandUseCase {
  final BaseCommandRepository repository;

  EditCommandUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Command command) async {
    return await repository.editCommand(command);
  }
}
