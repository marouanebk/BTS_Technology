import 'package:bts_technologie/authentication/data/datasource/user_datasource.dart';
import 'package:bts_technologie/authentication/data/repository/user_repository_implem.dart';
import 'package:bts_technologie/authentication/domaine/usecases/get_all_users_usecase.dart';
import 'package:bts_technologie/authentication/domaine/usecases/login_usecase.dart';
import 'package:bts_technologie/authentication/domaine/usecases/signup_usecase.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:bts_technologie/logistiques/data/datasource/article_datasource.dart';
import 'package:bts_technologie/logistiques/data/repository/article_repo_emplem.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/add_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/delete_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/edit_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_articles_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_undone_article_usecase.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_bloc.dart';
import 'package:bts_technologie/mainpage/data/Repository/account_repo_emplem.dart';
import 'package:bts_technologie/mainpage/data/dataSource/account_datasource.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_livreur_repo.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_pages_repo.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:bts_technologie/authentication/domaine/repository/user_repository.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // Bloc
    sl.registerFactory(() => UserBloc(sl(), sl()));
    sl.registerFactory(() => AccountBloc(sl(), sl(), sl()));
    sl.registerFactory(() => ArticleBloc(sl(), sl(), sl(), sl(), sl()));

    //Articles usecase

    //todo usecases
    sl.registerLazySingleton(() => GetArticlesUseCase(sl()));
    sl.registerLazySingleton(() => GetUnDoneArticleUseCase(sl()));
    sl.registerLazySingleton(() => AddArticleUseCase(sl()));
    sl.registerLazySingleton(() => EditArticleUseCase(sl()));
    sl.registerLazySingleton(() => DeleteArticleUseCase(sl()));

    // authentciation Usecases
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => CreateUserUseCase(sl()));
    sl.registerLazySingleton(() => GetAllUsersUseCase(sl()));

    // account

    sl.registerLazySingleton(() => GetPagesUseCase(sl()));
    sl.registerLazySingleton(() => GetLivreurUseCase(sl()));

    // Repository
    sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(sl()));
    sl.registerLazySingleton<BaseArticleRepository>(
        () => ArticleRepository(sl()));
    sl.registerLazySingleton<BaseAccountRepository>(
        () => AccountRepository(sl()));

    // sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(sl()));

    // Datasources
    sl.registerLazySingleton<BaseUserRemoteDateSource>(
        () => UserRemoteDataSource());
    sl.registerLazySingleton<BaseArticleRemoteDateSource>(
        () => ArticleRemoteDataSource());

    sl.registerLazySingleton<BaseAccountRemoteDateSource>(
        () => AccountRemoteDataSource());
  }
}
