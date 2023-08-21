import 'package:bts_technologie/authentication/data/datasource/user_datasource.dart';
import 'package:bts_technologie/authentication/data/repository/user_repository_implem.dart';
import 'package:bts_technologie/authentication/domaine/usecases/get_all_users_usecase.dart';
import 'package:bts_technologie/authentication/domaine/usecases/login_usecase.dart';
import 'package:bts_technologie/authentication/domaine/usecases/signup_usecase.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:bts_technologie/finances/data/datasource/finance_datasource.dart';
import 'package:bts_technologie/finances/data/repository/finance_repo_emplem.dart';
import 'package:bts_technologie/finances/domaine/repository/base_finance_repo.dart';
import 'package:bts_technologie/finances/domaine/usecases/get_cashflow_usecase.dart';
import 'package:bts_technologie/finances/domaine/usecases/get_finances_usecase.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_bloc.dart';
import 'package:bts_technologie/logistiques/data/datasource/article_datasource.dart';
import 'package:bts_technologie/logistiques/data/repository/article_repo_emplem.dart';
import 'package:bts_technologie/logistiques/domaine/repository/base_article_repo.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/add_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/delete_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/edit_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_articles_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_undone_article_usecase.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_bloc.dart';
import 'package:bts_technologie/mainpage/data/Repository/account_repo_emplem.dart';
import 'package:bts_technologie/mainpage/data/dataSource/account_datasource.dart';
import 'package:bts_technologie/mainpage/domaine/Repository/base_accounts_repo.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_clients_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_commands_stats_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_entreprise_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_livreur_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_pages_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_userinfo_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_admin_userstats_usecase.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/notifications/data/Repository/notification_repo_implem.dart';
import 'package:bts_technologie/notifications/data/dataSource/base_notifications_datasource.dart';
import 'package:bts_technologie/notifications/domaine/Repository/base_notification_repo.dart';
import 'package:bts_technologie/notifications/domaine/UseCase/get_notifications_usecase.dart';
import 'package:bts_technologie/notifications/presentation/controller/notification_bloc/notification_bloc.dart';
import 'package:bts_technologie/orders/data/Repository/commandes_repo_implem.dart';
import 'package:bts_technologie/orders/data/dataSource/commades_datasource.dart';
import 'package:bts_technologie/orders/domaine/Repository/base_command_repo.dart';
import 'package:bts_technologie/orders/domaine/UseCase/create_commande_usecase.dart';
import 'package:bts_technologie/orders/domaine/UseCase/edit_command_usecase.dart';
import 'package:bts_technologie/orders/domaine/UseCase/get_commandes_use_case.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:bts_technologie/authentication/domaine/repository/user_repository.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // Bloc
    sl.registerFactory(() => UserBloc(sl(), sl()));
    sl.registerFactory(() => AccountBloc(sl(), sl(), sl(), sl(), sl(), sl(),sl() ,sl()));
    sl.registerFactory(() => ArticleBloc(sl(), sl(), sl(), sl(), sl()));
    sl.registerFactory(() => CommandBloc(sl(), sl(), sl()));
    sl.registerFactory(() => FinanceBloc(sl(), sl()));
    sl.registerFactory(() => NotificationBloc(sl()));

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

    // account

    sl.registerLazySingleton(() => GetAllUsersUseCase(sl()));
    sl.registerLazySingleton(() => GetPagesUseCase(sl()));
    sl.registerLazySingleton(() => GetLivreurUseCase(sl()));
    sl.registerLazySingleton(() => GetEntrepriseInfoUsecase(sl()));
    sl.registerLazySingleton(() => GetAdminUserStatsUseCase(sl()));
    sl.registerLazySingleton(() => GetCommandsStatsUseCase(sl()));
    sl.registerLazySingleton(() => GetUserInfoUseCase(sl()));
    sl.registerLazySingleton(() => GetClientsUseCase(sl()));

    

    // Commandes
    sl.registerLazySingleton(() => GetCommandesUseCase(sl()));
    sl.registerLazySingleton(() => CreateCommandUseCase(sl()));
    sl.registerLazySingleton(() => EditCommandUseCase(sl()));

    // Finances
    sl.registerLazySingleton(() => GetFinancesUseCase(sl()));
    sl.registerLazySingleton(() => GetCashFlowUseCase(sl()));
    //
    sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));

    // Repository
    sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(sl()));
    sl.registerLazySingleton<BaseArticleRepository>(
        () => ArticleRepository(sl()));
    sl.registerLazySingleton<BaseAccountRepository>(
        () => AccountRepository(sl()));
    sl.registerLazySingleton<BaseCommandRepository>(
        () => CommandesRepository(sl()));

    sl.registerLazySingleton<BaseFinanceRepository>(
        () => FinanceRepository(sl()));

    sl.registerLazySingleton<BaseNotificationRepository>(
        () => NotificationsRepository(sl()));

    // sl.registerLazySingleton<BaseUserRepository>(() => UserRepository(sl()));

    // Datasources
    sl.registerLazySingleton<BaseUserRemoteDateSource>(
        () => UserRemoteDataSource());
    sl.registerLazySingleton<BaseArticleRemoteDateSource>(
        () => ArticleRemoteDataSource());

    sl.registerLazySingleton<BaseAccountRemoteDateSource>(
        () => AccountRemoteDataSource());

    sl.registerLazySingleton<BaseCommandRemoteDatasource>(
        () => CommandRemoteDataSource());

    sl.registerLazySingleton<BaseFinanceRemoteDateSource>(
        () => FinanceRemoteDataSource());
    //notification
    sl.registerLazySingleton<BaseNotificationsRemoteDateSource>(
        () => NotificationsRemoteDataSource());
  }
}
