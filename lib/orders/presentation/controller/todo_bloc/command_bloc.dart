import 'dart:async';

import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/orders/domaine/UseCase/create_commande_usecase.dart';
import 'package:bts_technologie/orders/domaine/UseCase/get_commandes_use_case.dart';
import 'package:bts_technologie/orders/presentation/controller/todo_bloc/command_event.dart';
import 'package:bts_technologie/orders/presentation/controller/todo_bloc/command_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommandBloc extends Bloc<CommandEvent, CommandesState> {
  final GetCommandesUseCase getCommandesUseCase;
  final CreateCommandUseCase createCommandUseCase;

  CommandBloc(this.getCommandesUseCase, this.createCommandUseCase)
      : super(const CommandesState()) {
    on<GetCommandesEvent>(_getCommandesEvent);
    on<CreateCommandEvent>(_createCommandEvent);
    // on<GetUnDoneTodoEvent>(_getUnDoneTodoEvent);
    // on<AddTodoEvent>(_addTodoEvent);
    // on<EditTodoEvent>(_editTodoEvent);
    // on<DeleteTodoEvent>(_deleteTodoEvent);
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
}
