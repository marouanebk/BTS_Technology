import 'dart:async';

import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/finances/domaine/usecases/get_finances_usecase.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_event.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinancesState> {
  final GetFinancesUseCase getFinancesUseCase;

  FinanceBloc(
    this.getFinancesUseCase,
  ) : super(const FinancesState()) {
    on<GetFinancesEvent>(_getFinancesEvent);
    // on<GetUnDoneTodoEvent>(_getUnDoneTodoEvent);
    // on<EditTodoEvent>(_editTodoEvent);
    // on<DeleteTodoEvent>(_deleteTodoEvent);
  }
  FutureOr<void> _getFinancesEvent(
      GetFinancesEvent event, Emitter<FinancesState> emit) async {
    final result = await getFinancesUseCase();
    result.fold(
        (l) => emit(state.copyWith(
            getFinancesState: RequestState.error,
            getFinancesmessage: l.message)),
        (r) => emit(state.copyWith(
            getFinances: r, getFinancesState: RequestState.loaded)));
  }

  // FutureOr<void> _createArticlesEvent(
  //     CreateArticleEvent event, Emitter<ArticleState> emit) async {
  //   final result = await createArticleUseCase(event.article);
  //   result.fold(
  //       (l) => emit(state.copyWith(
  //           createArticleState: RequestState.error,
  //           createArticleMessage: l.message)),
  //       (r) => emit(state.copyWith(createArticleState: RequestState.loaded)));
  // }

  // FutureOr<void> _getUnDoneTodoEvent(
  //     GetUnDoneTodoEvent event, Emitter<TodoState> emit) async {
  //   final result = await getUnDoneTodoUseCase();
  //   result.fold(
  //       (l) => emit(state.copyWith(
  //           getUnDoneTodoState: RequestState.error,
  //           getUnDoneTodomessage: l.message)),
  //       (r) => emit(state.copyWith(
  //           getUnDoneTodo: r, getUnDoneTodoState: RequestState.loaded)));
  // }

  // FutureOr<void> _editTodoEvent(
  //     EditTodoEvent event, Emitter<TodoState> emit) async {
  //   final result = await getFinancesUseCase();
  //   result.fold(
  //       (l) => emit(state.copyWith(
  //           getFinancesState: RequestState.error,
  //           getFinancesmessage: l.message)),
  //       (r) => emit(state.copyWith(
  //           getFinances: r, getFinancesState: RequestState.loaded)));
  // }

  // FutureOr<void> _deleteTodoEvent(
  //     DeleteTodoEvent event, Emitter<TodoState> emit) async {
  //   final result = await getFinancesUseCase();
  //   result.fold(
  //       (l) => emit(state.copyWith(
  //           getFinancesState: RequestState.error,
  //           getFinancesmessage: l.message)),
  //       (r) => emit(state.copyWith(
  //           getFinances: r, getFinancesState: RequestState.loaded)));
  // }
}
