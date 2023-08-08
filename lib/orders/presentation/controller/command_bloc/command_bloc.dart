import 'dart:async';

import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/orders/domaine/UseCase/create_commande_usecase.dart';
import 'package:bts_technologie/orders/domaine/UseCase/edit_command_usecase.dart';
import 'package:bts_technologie/orders/domaine/UseCase/get_commandes_use_case.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_event.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommandBloc extends Bloc<CommandEvent, CommandesState> {
  final GetCommandesUseCase getCommandesUseCase;
  final CreateCommandUseCase createCommandUseCase;
  final EditCommandUseCase editCommandUseCase;

  CommandBloc(this.getCommandesUseCase, this.createCommandUseCase,
      this.editCommandUseCase)
      : super(const CommandesState()) {
    on<GetCommandesEvent>(_getCommandesEvent);
    on<CreateCommandEvent>(_createCommandEvent);
    on<EditCommandEvent>(_editCommandEvent);

  }
  FutureOr<void> _getCommandesEvent(
      GetCommandesEvent event, Emitter<CommandesState> emit) async {
    final result = await getCommandesUseCase();
    result.fold(
        (l) => emit(state.copyWith(
            getCommandesState: RequestState.error,
            getCommandesmessage: l.message)),
        (r) => emit(state.copyWith(
            getCommandes: r, getCommandesState: RequestState.loaded)));
  }

  FutureOr<void> _createCommandEvent(
      CreateCommandEvent event, Emitter<CommandesState> emit) async {
    emit(
      state.copyWith(
        createCommandState: RequestState.loading,
      ),
    );
    final result = await createCommandUseCase(event.command);
    result.fold(
        (l) => emit(state.copyWith(
            createCommandState: RequestState.error,
            createCommandMessage: l.message)),
        (r) => emit(state.copyWith(createCommandState: RequestState.loaded)));
  }

  FutureOr<void> _editCommandEvent(
      EditCommandEvent event, Emitter<CommandesState> emit) async {
    emit(
      state.copyWith(
        editCommandState: RequestState.loading,
      ),
    );
    final result = await editCommandUseCase(event.command);
    result.fold(
        (l) => emit(state.copyWith(
            editCommandState: RequestState.error,
            editCommandMessage: l.message)),
        (r) => emit(state.copyWith(editCommandState: RequestState.loaded)));
  }
}
