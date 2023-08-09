import 'dart:async';

import 'package:bts_technologie/authentication/domaine/usecases/get_all_users_usecase.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_commands_stats_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_entreprise_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_livreur_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_pages_usecase.dart';
import 'package:bts_technologie/mainpage/domaine/UseCase/get_usestats_usecase.dart';

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

  AccountBloc(
    this.getAllUsersUseCase,
    this.getLivreurUseCase,
    this.getPagesUseCase,
    this.getEntrepriseInfoUsecase,
    this.getAdminUserStatsUseCase,
    this.getCommandsStatsUseCase,
  ) : super(const AccountState()) {
    on<GetAllAccountsEvent>(_getAccountEvent);
    on<GetPagesEvent>(_getPagesEvent);
    on<GetLivreursEvent>(_getLivreursEvent);
    on<GetEntrepriseInfoEvent>(_getEntrepriseInfoEvent);
    on<GetAdminUserStatsEvent>(_getAdminUsersStatsEvent);
    on<GetCommandsStatsEvent>(_getCommandsStatsEvent);
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

  FutureOr<void> _getAccountEvent(
      GetAllAccountsEvent event, Emitter<AccountState> emit) async {
    final result = await getAllUsersUseCase();
    result.fold(
        (l) => emit(state.copyWith(
            getAccountState: RequestState.error, getAccountmessage: l.message)),
        (r) => emit(state.copyWith(
            getAccount: r, getAccountState: RequestState.loaded)));
  }

  FutureOr<void> _getPagesEvent(
      GetPagesEvent event, Emitter<AccountState> emit) async {
    final result = await getPagesUseCase();
    result.fold(
        (l) => emit(state.copyWith(
            getPagesState: RequestState.error, getPagesmessage: l.message)),
        (r) => emit(
            state.copyWith(getPages: r, getPagesState: RequestState.loaded)));
  }

  FutureOr<void> _getCommandsStatsEvent(
      GetCommandsStatsEvent event, Emitter<AccountState> emit) async {
    final result = await getCommandsStatsUseCase();
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
    result.fold(
        (l) => emit(state.copyWith(
            getAdminUserStatsState: RequestState.error,
            getAdminUserStatsmessage: l.message)),
        (r) => emit(state.copyWith(
            getAdminUserStats: r,
            getAdminUserStatsState: RequestState.loaded)));
  }

  FutureOr<void> _getLivreursEvent(
      GetLivreursEvent event, Emitter<AccountState> emit) async {
    final result = await getLivreurUseCase();
    result.fold(
        (l) => emit(state.copyWith(
            getLivreursState: RequestState.error,
            getLivreursmessage: l.message)),
        (r) => emit(state.copyWith(
            getLivreurs: r, getLivreursState: RequestState.loaded)));
  }
}
