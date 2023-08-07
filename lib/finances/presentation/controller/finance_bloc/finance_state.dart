import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';

class FinancesState extends Equatable {
  final List<FinanceEntity> getFinances;
  final RequestState getFinancesState;
  final String getFinancesmessage;
  //

  // final ToDo createArticle;
  final RequestState createArticleState;
  final String createArticleMessage;

  const FinancesState({
    this.getFinances = const [],
    this.getFinancesState = RequestState.loading,
    this.getFinancesmessage = "",
    //

    //
    this.createArticleState = RequestState.loading,
    this.createArticleMessage = "",
  });

  FinancesState copyWith({
    List<FinanceEntity>? getFinances,
    RequestState? getFinancesState,
    String? getFinancesmessage,
    //

    //
    RequestState? createArticleState,
    String? createArticleMessage,
  }) {
    return FinancesState(
      getFinances: getFinances ?? this.getFinances,
      getFinancesState: getFinancesState ?? this.getFinancesState,
      getFinancesmessage: getFinancesmessage ?? this.getFinancesmessage,
      //

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

        createArticleState,
        createArticleMessage,
        //
      ];
}
