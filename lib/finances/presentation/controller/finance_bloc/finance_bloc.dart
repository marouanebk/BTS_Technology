import 'dart:async';

import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/finances/domaine/usecases/get_cashflow_usecase.dart';
import 'package:bts_technologie/finances/domaine/usecases/get_finances_usecase.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_event.dart';
import 'package:bts_technologie/finances/presentation/controller/finance_bloc/finance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinancesState> {
  final GetFinancesUseCase getFinancesUseCase;
  final GetCashFlowUseCase getCashFlowUseCase;

  FinanceBloc(
    this.getFinancesUseCase,
    this.getCashFlowUseCase,
  ) : super(const FinancesState()) {
    on<GetFinancesEvent>(_getFinancesEvent);
    on<GetCashFlowEvent>(_getCashFLow);
    // on<GetUnDoneTodoEvent>(_getUnDoneTodoEvent);
    // on<EditTodoEvent>(_editTodoEvent);
    // on<DeleteTodoEvent>(_deleteTodoEvent);
  }
  FutureOr<void> _getFinancesEvent(
      GetFinancesEvent event, Emitter<FinancesState> emit) async {
    emit(state.copyWith(getFinancesState: RequestState.loading));
    final result = await getFinancesUseCase();
    result.fold(
        (l) => emit(state.copyWith(
            getFinancesState: RequestState.error,
            getFinancesmessage: l.message)),
        (r) => emit(state.copyWith(
            getFinances: r, getFinancesState: RequestState.loaded)));
  }

  FutureOr<void> _getCashFLow(
      GetCashFlowEvent event, Emitter<FinancesState> emit) async {
            emit(state.copyWith(getCashFlowState: RequestState.loading));

    final result = await getCashFlowUseCase();
    result.fold(
      (l) => emit(
        state.copyWith(
            getCashFlowState: RequestState.error,
            getCashFlowmessage: l.message),
      ),
      (r) => emit(
        state.copyWith(
          getCashFlow: r,
          getCashFlowState: RequestState.loaded,
        ),
      ),
    );
  }

}
