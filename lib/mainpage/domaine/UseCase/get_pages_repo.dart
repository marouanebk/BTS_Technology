import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:dartz/dartz.dart';

class GetPagesUseCase {
  final BaseAccountRepository repository;

  GetPagesUseCase(this.repository);

  Future<Either<Failure, List<FacePage>>> call() async {
    return await repository.getPages();
  }
}
