import 'dart:async';

import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/add_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/delete_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/edit_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_articles_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_undone_article_usecase.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_event.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_state.dart';
import 'package:bts_technologie/orders/domaine/UseCase/get_commandes_use_case.dart';
import 'package:bts_technologie/orders/presentation/controller/todo_bloc/article_event.dart';
import 'package:bts_technologie/orders/presentation/controller/todo_bloc/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommandBloc extends Bloc<CommandEvent, CommandesState> {
  final GetCommandesUseCase getCommandesUseCase;

  CommandBloc(
    this.getCommandesUseCase,
  ) : super(const CommandesState()) {
    on<GetCommandesEvent>(_getCommandesEvent);
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
}
