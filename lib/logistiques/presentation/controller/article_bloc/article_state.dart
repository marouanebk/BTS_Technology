import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:equatable/equatable.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';

class ArticleState extends Equatable {
  final List<Article> getArticles;
  final RequestState getArticlesState;
  final String getArticlesmessage;
  //
  final List<Article> getUnDoneTodo;
  final RequestState getUnDoneTodoState;
  final String getUnDoneTodomessage;

  // final ToDo createArticle;
  final RequestState createArticleState;
  final String createArticleMessage;

  const ArticleState({
    this.getArticles = const [],
    this.getArticlesState = RequestState.loading,
    this.getArticlesmessage = "",
    //
    this.getUnDoneTodo = const [],
    this.getUnDoneTodoState = RequestState.loading,
    this.getUnDoneTodomessage = "",
    //
    this.createArticleState = RequestState.initial,
    this.createArticleMessage = "",
  });

  ArticleState copyWith({
    List<Article>? getArticles,
    RequestState? getArticlesState,
    String? getArticlesmessage,
    //
    List<Article>? getUnDoneTodo,
    RequestState? getUnDoneTodoState,
    String? getUnDoneTodomessage,
    //
    RequestState? createArticleState,
    String? createArticleMessage,
  }) {
    return ArticleState(
      getArticles: getArticles ?? this.getArticles,
      getArticlesState: getArticlesState ?? this.getArticlesState,
      getArticlesmessage: getArticlesmessage ?? this.getArticlesmessage,
      //
      getUnDoneTodo: getUnDoneTodo ?? this.getUnDoneTodo,
      getUnDoneTodoState: getUnDoneTodoState ?? this.getUnDoneTodoState,
      getUnDoneTodomessage: getUnDoneTodomessage ?? this.getUnDoneTodomessage,
      //
      createArticleState: createArticleState ?? this.createArticleState,
      createArticleMessage: createArticleMessage ?? this.createArticleMessage,
    );
    //
  }

  @override
  List<Object?> get props => [
        getArticles,
        getArticlesState,
        getArticlesmessage,
        //
        getUnDoneTodo,
        getUnDoneTodoState,
        getUnDoneTodomessage,
        
        createArticleState,
        createArticleMessage,
        //
      ];
}
