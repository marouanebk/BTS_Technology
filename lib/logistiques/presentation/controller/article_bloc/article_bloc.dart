import 'dart:async';

import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/add_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/delete_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/edit_article_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_articles_usecase.dart';
import 'package:bts_technologie/logistiques/domaine/usecases/get_undone_article_usecase.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_event.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;
  final GetUnDoneArticleUseCase getUnDoneTodoUseCase;
  final AddArticleUseCase createArticleUseCase;
  final EditArticleUseCase editTodoUseCase;
  final DeleteArticleUseCase deleteTodoUseCase;
  ArticleBloc(this.getArticlesUseCase, this.getUnDoneTodoUseCase,
      this.createArticleUseCase, this.editTodoUseCase, this.deleteTodoUseCase)
      : super(const ArticleState()) {
    on<GetArticlesEvent>(_getArticlesEvent);
    // on<GetUnDoneTodoEvent>(_getUnDoneTodoEvent);
    on<CreateArticleEvent>(_createArticlesEvent);
    // on<EditTodoEvent>(_editTodoEvent);
    // on<DeleteTodoEvent>(_deleteTodoEvent);
  }
  FutureOr<void> _getArticlesEvent(
      GetArticlesEvent event, Emitter<ArticleState> emit) async {
    emit(state.copyWith(getArticlesState: RequestState.loading));
    final result = await getArticlesUseCase();

    result.fold(
        (l) => emit(state.copyWith(
            getArticlesState: RequestState.error,
            getArticlesmessage: l.message)),
        (r) => emit(state.copyWith(
            getArticles: r, getArticlesState: RequestState.loaded)));
  }

  FutureOr<void> _createArticlesEvent(
      CreateArticleEvent event, Emitter<ArticleState> emit) async {
    final result = await createArticleUseCase(event.article);
    emit(state.copyWith(createArticleState: RequestState.loading));

    result.fold(
        (l) => emit(state.copyWith(
            createArticleState: RequestState.error,
            createArticleMessage: l.message)),
        (r) => emit(state.copyWith(createArticleState: RequestState.loaded)));
  }
}
