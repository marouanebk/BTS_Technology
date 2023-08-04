import 'dart:developer';

import 'package:bts_technologie/authentification/data/Repository/user_repository_implemetation.dart';
import 'package:bts_technologie/authentification/data/dataSource/user_datasource.dart';
import 'package:bts_technologie/authentification/domaine/UseCase/login_usecase.dart';
import 'package:bts_technologie/authentification/domaine/UseCase/signup_usecase.dart';
import 'package:bts_technologie/authentification/domaine/repository/user_repository.dart';
import 'package:bts_technologie/authentification/presentation/controller/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    sl.registerFactory(() => AuthBloc(sl(), sl()));

    sl.registerLazySingleton(() => SignUpUseCase(sl()));

    sl.registerLazySingleton(() => LoginUseCase(sl()));

    sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(sl()));

    sl.registerLazySingleton<BaseUserRemoteDateSource>(
        () => UserRemoteDataSource());
  }
}
