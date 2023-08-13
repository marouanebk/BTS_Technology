import 'dart:developer';
import 'dart:io';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseArticleRemoteDateSource {
  Future<Unit> addArticle(ArticleModel article);
  Future<Unit> deleteArticle(Article article);
  Future<Unit> editArticle(Article article);
  Future<List<Article>> getArticles();
  Future<List<Article>> getUnDoneArticle();
}

class ArticleRemoteDataSource extends BaseArticleRemoteDateSource {
  @override
  Future<Unit> addArticle(ArticleModel article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    var formData = FormData.fromMap(article.toJson());
    if (article.photo != null) {
      log("there is a picture in the");
      formData.files.add(MapEntry(
        'photo',
        await MultipartFile.fromFile(article.photo!.path),
      ));
    }
    final photoEntry = formData.files.firstWhere(
      (entry) => entry.key == 'photo',
      orElse: () => MapEntry('', MultipartFile.fromString('')),
    );
    if (photoEntry.key == 'photo') {
      log('Photo: ${photoEntry.value}');
    } else {
      log('No photo found in formData');
    }

    final imageFile = File(article.photo!.path);
    if (imageFile.existsSync()) {
      log("correct");
    } else {
      log("false");
    }

    final response = await Dio().post(
      ApiConstance.createArticle,
      data: formData,
      options: Options(
        followRedirects: false,
        headers: {
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
     String errorMessage = response.data['err'] ?? "Unknown error";
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: errorMessage,
        ),
      );
    }
  }

  @override
  Future<List<Article>> getArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getArticles,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      return List<ArticleModel>.from((response.data as List).map(
        (e) => ArticleModel.fromJson(e),
      ));
    } else {
     String errorMessage = response.data['err'] ?? "Unknown error";
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: errorMessage,
        ),
      );
    }
  }

  @override
  Future<Unit> deleteArticle(Article article) {
    throw UnimplementedError();
  }

  @override
  Future<Unit> editArticle(Article article) {
    throw UnimplementedError();
  }

  @override
  Future<List<Article>> getUnDoneArticle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userid");

    final response = await Dio().get(
      "http://10.0.2.2:4000/Articles/undone/$userid",
    );
    if (response.statusCode == 200) {
      return List<ArticleModel>.from((response.data["Article"] as List).map(
        (e) => ArticleModel.fromJson(e),
      ));
    } else {
      String errorMessage = response.data['err'] ?? "Unknown error";
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: errorMessage,
        ),
      );
    }
  }
}
