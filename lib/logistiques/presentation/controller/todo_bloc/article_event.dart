import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class GetArticlesEvent extends ArticleEvent {}

class GetUnDoneTodoEvent extends ArticleEvent {}

class CreateArticleEvent extends ArticleEvent {
  final Article article;
  const CreateArticleEvent({required this.article});

  @override
  List<Object> get props => [article];
}

class EditTodoEvent extends ArticleEvent {}

class DeleteTodoEvent extends ArticleEvent {}
