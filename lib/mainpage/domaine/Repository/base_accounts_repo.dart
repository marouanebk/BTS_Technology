import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/command_stats_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/entreprise_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/user_stat_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAccountRepository {
  Future<Either<Failure, List<FacePage>>> getPages();
  Future<Either<Failure, List<Livreur>>> getLivreurs();
  Future<Either<Failure, List<CommandStatsEntity>>> getCommandStats();
  Future<Either<Failure, Entreprise>> getEntrepriseInfo();
  Future<Either<Failure, User>> getUserInfo();
  Future<Either<Failure, List<UserStatEntity>>> getUsersStats();

}
