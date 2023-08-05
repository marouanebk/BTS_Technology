import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class GetArticlesEvent extends ArticleEvent {}

class GetUnDoneTodoEvent extends ArticleEvent {}

class AddTodoEvent extends ArticleEvent {
  final Article todo;
  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditTodoEvent extends ArticleEvent {}

class DeleteTodoEvent extends ArticleEvent {}
