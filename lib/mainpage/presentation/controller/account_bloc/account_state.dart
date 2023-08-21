import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/command_stats_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/entreprise_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/user_stat_entity.dart';
import 'package:equatable/equatable.dart';

class AccountState extends Equatable {
  final List<User> getAccount;
  final RequestState getAccountState;
  final String getAccountmessage;
  //
  final List<FacePage> getPages;
  final RequestState getPagesState;
  final String getPagesmessage;

  final List<Livreur> getLivreurs;
  final RequestState getLivreursState;
  final String getLivreursmessage;

  final List<CommandStatsEntity> getCommandsStats;
  final RequestState getCommandsStatsState;
  final String getCommandsStatsmessage;

  final Entreprise? getEntrepriseInfo;
  final RequestState getEntrepriseInfoState;
  final String getEntrepriseInfomessage;

  final List<UserStatEntity> getAdminUserStats;
  final RequestState getAdminUserStatsState;
  final String getAdminUserStatsmessage;

  final List<UserStatEntity> getClientsStats;
  final RequestState getClientsState;
  final String getClientsmessage;

  final User? getUserInfo;
  final RequestState getUserInfoState;
  final String getUserInfomessage;

  // final ToDo createArticle;
  final RequestState createArticleState;
  final String createArticleMessage;

  const AccountState({
    this.getAccount = const [],
    this.getAccountState = RequestState.loading,
    this.getAccountmessage = "",
    //
    this.getPages = const [],
    this.getPagesState = RequestState.loading,
    this.getPagesmessage = "",
    //
    this.getLivreurs = const [],
    this.getLivreursState = RequestState.loading,
    this.getLivreursmessage = "",
    //
    this.getCommandsStats = const [],
    this.getCommandsStatsState = RequestState.loading,
    this.getCommandsStatsmessage = "",
    //
    this.createArticleState = RequestState.loading,
    this.createArticleMessage = "",
    //
    this.getEntrepriseInfo = null,
    this.getEntrepriseInfoState = RequestState.loading,
    this.getEntrepriseInfomessage = "",
    //
    this.getAdminUserStats = const [],
    this.getAdminUserStatsState = RequestState.loading,
    this.getAdminUserStatsmessage = "",
    //
    this.getClientsStats = const [],
    this.getClientsState = RequestState.loading,
    this.getClientsmessage = "",
    //
    this.getUserInfo = null,
    this.getUserInfoState = RequestState.loading,
    this.getUserInfomessage = "",
  });

  AccountState copyWith({
    List<User>? getAccount,
    RequestState? getAccountState,
    String? getAccountmessage,
    //
    List<FacePage>? getPages,
    RequestState? getPagesState,
    String? getPagesmessage,
    //

    List<Livreur>? getLivreurs,
    RequestState? getLivreursState,
    String? getLivreursmessage,

    //
    List<CommandStatsEntity>? getCommandsStats,
    RequestState? getCommandsStatsState,
    String? getCommandsStatsmessage,
    //
    Entreprise? getEntrepriseInfo,
    RequestState? getEntrepriseInfoState,
    String? getEntrepriseInfomessage,
    //
    RequestState? createArticleState,
    String? createArticleMessage,
    //
    List<UserStatEntity>? getAdminUserStats,
    RequestState? getAdminUserStatsState,
    String? getAdminUserStatsmessage,
    //
    List<UserStatEntity>? getClientsStats,
    RequestState? getClientsState,
    String? getClientsmessage,
    //
    User? getUserInfo,
    RequestState? getUserInfoState,
    String? getUserInfomessage,
  }) {
    return AccountState(
      getAccount: getAccount ?? this.getAccount,
      getAccountState: getAccountState ?? this.getAccountState,
      getAccountmessage: getAccountmessage ?? this.getAccountmessage,
      //
      getPages: getPages ?? this.getPages,
      getPagesState: getPagesState ?? this.getPagesState,
      getPagesmessage: getPagesmessage ?? this.getPagesmessage,
      //
      //
      getLivreurs: getLivreurs ?? this.getLivreurs,
      getLivreursState: getLivreursState ?? this.getLivreursState,
      getLivreursmessage: getLivreursmessage ?? this.getLivreursmessage,
      //

      getEntrepriseInfo: getEntrepriseInfo ?? this.getEntrepriseInfo,
      getEntrepriseInfoState:
          getEntrepriseInfoState ?? this.getEntrepriseInfoState,
      getEntrepriseInfomessage:
          getEntrepriseInfomessage ?? this.getEntrepriseInfomessage,
      createArticleState: createArticleState ?? this.createArticleState,
      createArticleMessage: createArticleMessage ?? this.createArticleMessage,
      /////////
      getAdminUserStats: getAdminUserStats ?? this.getAdminUserStats,
      getAdminUserStatsState:
          getAdminUserStatsState ?? this.getAdminUserStatsState,
      getAdminUserStatsmessage:
          getAdminUserStatsmessage ?? this.getAdminUserStatsmessage,
      //
      getClientsStats: getClientsStats ?? this.getClientsStats,
      getClientsState: getClientsState ?? this.getClientsState,
      getClientsmessage: getClientsmessage ?? this.getClientsmessage,
      //
      getCommandsStats: getCommandsStats ?? this.getCommandsStats,
      getCommandsStatsState:
          getCommandsStatsState ?? this.getCommandsStatsState,
      getCommandsStatsmessage:
          getCommandsStatsmessage ?? this.getCommandsStatsmessage,

      getUserInfo: getUserInfo ?? this.getUserInfo,
      getUserInfoState: getUserInfoState ?? this.getUserInfoState,
      getUserInfomessage: getUserInfomessage ?? this.getUserInfomessage,
    );
    //
  }

  @override
  List<Object?> get props => [
        getAccount,
        getAccountState,
        getAccountmessage,
        //
        getPages,
        getPagesState,
        getPagesmessage,

        getEntrepriseInfo,
        getEntrepriseInfoState,
        getEntrepriseInfomessage,
        getLivreurs,
        getLivreursState,
        getLivreursmessage,

        createArticleState,
        createArticleMessage,
        //
        getAdminUserStats,
        getAdminUserStatsState,
        getAdminUserStatsmessage,
        //
        getCommandsStats,
        getCommandsStatsState,
        getCommandsStatsmessage,
        //

        getClientsStats,
        getClientsState,
        getClientsmessage,
        //
        getUserInfo,
        getUserInfoState,
        getUserInfomessage,
      ];
}
