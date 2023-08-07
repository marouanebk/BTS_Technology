import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FinanceEvent extends Equatable {
  const FinanceEvent();

  @override
  List<Object> get props => [];
}

class GetFinancesEvent extends FinanceEvent {}


class CreateArticleEvent extends FinanceEvent {
  final Article article;
  const CreateArticleEvent({required this.article});

  @override
  List<Object> get props => [article];
}
