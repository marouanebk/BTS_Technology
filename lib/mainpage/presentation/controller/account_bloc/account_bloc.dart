import 'dart:async';
import 'dart:developer';

import 'package:bts_technologie/authentication/domaine/usecases/get_all_users_usecase.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_clients_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_commands_stats_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_entreprise_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_livreur_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_pages_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_userinfo_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_admin_userstats_usecase.dart';

import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetPagesUseCase getPagesUseCase;
  final GetLivreurUseCase getLivreurUseCase;
  final GetEntrepriseInfoUsecase getEntrepriseInfoUsecase;
  final GetAdminUserStatsUseCase getAdminUserStatsUseCase;
  final GetCommandsStatsUseCase getCommandsStatsUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final GetClientsUseCase getClientsUseCase;

  AccountBloc(
    this.getAllUsersUseCase,
    this.getLivreurUseCase,
    this.getPagesUseCase,
    this.getEntrepriseInfoUsecase,
    this.getAdminUserStatsUseCase,
    this.getCommandsStatsUseCase,
    this.getUserInfoUseCase,
    this.getClientsUseCase,
  ) : super(const AccountState()) {
    on<GetAllAccountsEvent>(_getAllAccountsEvent);
    on<GetPagesEvent>(_getPagesEvent);
    on<GetLivreursEvent>(_getLivreursEvent);
    on<GetEntrepriseInfoEvent>(_getEntrepriseInfoEvent);
    on<GetAdminUserStatsEvent>(_getAdminUsersStatsEvent);
    on<GetClientsEvent>(_getClientsEvent);
    on<GetCommandsStatsEvent>(_getCommandsStatsEvent);
    on<GetUserInfoEvent>(_getUserInfoEvent);
  }

  FutureOr<void> _getUserInfoEvent(
      GetUserInfoEvent event, Emitter<AccountState> emit) async {
    final result = await getUserInfoUseCase();
    emit(state.copyWith(
      getUserInfoState: RequestState.loading,
    ));

    result.fold((l) {
      emit(state.copyWith(
          getUserInfoState: RequestState.error, getUserInfomessage: l.message));
    },
        (r) => emit(state.copyWith(
            getUserInfo: r, getUserInfoState: RequestState.loaded)));
  }

  FutureOr<void> _getEntrepriseInfoEvent(
      GetEntrepriseInfoEvent event, Emitter<AccountState> emit) async {
    final result = await getEntrepriseInfoUsecase();
    result.fold(
        (l) => emit(state.copyWith(
            getEntrepriseInfoState: RequestState.error,
            getEntrepriseInfomessage: l.message)),
        (r) => emit(state.copyWith(
            getEntrepriseInfo: r,
            getEntrepriseInfoState: RequestState.loaded)));
  }

  FutureOr<void> _getAllAccountsEvent(
      GetAllAccountsEvent event, Emitter<AccountState> emit) async {
    final result = await getAllUsersUseCase();
    emit(state.copyWith(
      getAccountState: RequestState.loading,
    ));
    result.fold(
        (l) => emit(state.copyWith(
            getAccountState: RequestState.error, getAccountmessage: l.message)),
        (r) => emit(state.copyWith(
            getAccount: r, getAccountState: RequestState.loaded)));
  }

  FutureOr<void> _getPagesEvent(
      GetPagesEvent event, Emitter<AccountState> emit) async {
    final result = await getPagesUseCase();
    emit(state.copyWith(
      getPagesState: RequestState.loading,
    ));
    result.fold(
        (l) => emit(state.copyWith(
            getPagesState: RequestState.error, getPagesmessage: l.message)),
        (r) => emit(
            state.copyWith(getPages: r, getPagesState: RequestState.loaded)));
  }

  FutureOr<void> _getCommandsStatsEvent(
      GetCommandsStatsEvent event, Emitter<AccountState> emit) async {
    final result = await getCommandsStatsUseCase();
    emit(state.copyWith(
      getCommandsStatsState: RequestState.loading,
    ));

    result.fold(
        (l) => emit(state.copyWith(
            getCommandsStatsState: RequestState.error,
            getCommandsStatsmessage: l.message)),
        (r) => emit(state.copyWith(
            getCommandsStats: r, getCommandsStatsState: RequestState.loaded)));
  }

  FutureOr<void> _getAdminUsersStatsEvent(
      GetAdminUserStatsEvent event, Emitter<AccountState> emit) async {
    final result = await getAdminUserStatsUseCase();
    emit(state.copyWith(
      getAdminUserStatsState: RequestState.loading,
    ));
    result.fold(
        (l) => emit(state.copyWith(
            getAdminUserStatsState: RequestState.error,
            getAdminUserStatsmessage: l.message)),
        (r) => emit(state.copyWith(
            getAdminUserStats: r,
            getAdminUserStatsState: RequestState.loaded)));
  }

  FutureOr<void> _getClientsEvent(
      GetClientsEvent event, Emitter<AccountState> emit) async {
    final result = await getClientsUseCase();
    emit(state.copyWith(
      getClientsState: RequestState.loading,
    ));
    result.fold(
        (l) => emit(state.copyWith(
            getClientsState: RequestState.error, getClientsmessage: l.message)),
        (r) => emit(state.copyWith(
            getClientsStats: r, getClientsState: RequestState.loaded)));
  }

  FutureOr<void> _getLivreursEvent(
      GetLivreursEvent event, Emitter<AccountState> emit) async {
    emit(state.copyWith(
      getLivreursState: RequestState.loading,
    ));
    final result = await getLivreurUseCase();

    result.fold(
        (l) => emit(state.copyWith(
            getLivreursState: RequestState.error,
            getLivreursmessage: l.message)),
        (r) => emit(state.copyWith(
            getLivreurs: r, getLivreursState: RequestState.loaded)));
  }
}
