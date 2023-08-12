import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/finances/domaine/entities/cashflow_entity.dart';
import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';
import 'package:equatable/equatable.dart';

class FinancesState extends Equatable {
  final List<FinanceEntity> getFinances;
  final RequestState getFinancesState;
  final String getFinancesmessage;
  //
  final CashFlow? getCashFlow;
  final RequestState getCashFlowState;
  final String getCashFlowmessage;

  // final ToDo createArticle;
  final RequestState createArticleState;
  final String createArticleMessage;

  const FinancesState({
    this.getFinances = const [],
    this.getFinancesState = RequestState.loading,
    this.getFinancesmessage = "",
    //
    this.getCashFlow = null,
    this.getCashFlowState = RequestState.loading,
    this.getCashFlowmessage = "",

    //
    this.createArticleState = RequestState.loading,
    this.createArticleMessage = "",
  });

  FinancesState copyWith({
    List<FinanceEntity>? getFinances,
    RequestState? getFinancesState,
    String? getFinancesmessage,
    //
    CashFlow? getCashFlow,
    RequestState? getCashFlowState,
    String? getCashFlowmessage,

    //
    RequestState? createArticleState,
    String? createArticleMessage,
  }) {
    return FinancesState(
      getFinances: getFinances ?? this.getFinances,
      getFinancesState: getFinancesState ?? this.getFinancesState,
      getFinancesmessage: getFinancesmessage ?? this.getFinancesmessage,
      //
      getCashFlow: getCashFlow ?? this.getCashFlow,
      getCashFlowState: getCashFlowState ?? this.getCashFlowState,
      getCashFlowmessage: getCashFlowmessage ?? this.getCashFlowmessage,

      //
      createArticleState: createArticleState ?? this.createArticleState,
      createArticleMessage: createArticleMessage ?? this.createArticleMessage,
    );
    //
  }

  @override
  List<Object?> get props => [
        getFinances,
        getFinancesState,
        getFinancesmessage,

        getCashFlow,
        getCashFlowState,
        getCashFlowmessage,
        //
        createArticleState,
        createArticleMessage,
        //
      ];
}
