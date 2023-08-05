import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
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
    this.getLivreurs = const [],
    this.getLivreursState = RequestState.loading,
    this.getLivreursmessage = "",
    //
    this.createArticleState = RequestState.loading,
    this.createArticleMessage = "",
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
    RequestState? createArticleState,
    String? createArticleMessage,
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
      createArticleState: createArticleState ?? this.createArticleState,
      createArticleMessage: createArticleMessage ?? this.createArticleMessage,
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

        getLivreurs,
        getLivreursState,
        getLivreursmessage,

        createArticleState,
        createArticleMessage,
        //
      ];
}
