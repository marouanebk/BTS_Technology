

import 'package:bts_technologie/authentication/data/datasource/user_datasource.dart';
import 'package:bts_technologie/authentication/data/repository/user_repository_implem.dart';
import 'package:bts_technologie/authentication/domaine/usecases/login_usecase.dart';
import 'package:bts_technologie/authentication/domaine/usecases/logout_usecase.dart';
import 'package:bts_technologie/authentication/domaine/usecases/signup_usecase.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:bts_technologie/authentication/domaine/repository/user_repository.dart';
final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // Bloc
    sl.registerFactory(() => UserBloc(sl(), sl()));


    // sl.registerFactory(() => UserBloc(
    // createUserUseCase: sl(), loginUserCase: sl()));
    // authentciation Usecases
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => CreateUserUseCase(sl()));


    // Repository
    sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(sl()));


    // sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(sl()));

    // Datasources

    //todo
    sl.registerLazySingleton<BaseUserRemoteDateSource>(
        () => UserRemoteDataSource());

  }
}
