import 'dart:developer';

import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseCommandRemoteDatasource {
  Future<List<CommandModel>> getCommandes();
  Future<Unit> createCommand(CommandModel command);
  Future<Unit> editCommand(CommandModel command);
}

class CommandRemoteDataSource extends BaseCommandRemoteDatasource {
  @override
  Future<List<CommandModel>> getCommandes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getCommandes,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      // return List<CommandModel>.from(
      //     (response.data as List).map((e) => CommandModel.fromJson(e)));

      return CommandModel.fromJsonList(response.data);
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
  Future<Unit> createCommand(CommandModel command) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    var formData = FormData();
    formData.fields.addAll([
      MapEntry('prixSoutraitant', command.prixSoutraitant.toString()),
      MapEntry('nomClient', command.nomClient),
      MapEntry('adresse', command.adresse),
      MapEntry('phoneNumber', command.phoneNumber.toString()),
      MapEntry('sommePaid', command.sommePaid.toString()),
    ]);

    if (command.noteClient != null) {
      formData.fields.add(MapEntry('noteClient', command.noteClient!));
    }
    if (command.page != null) {
      formData.fields.add(MapEntry('page', command.page!));
    }

    // Add the article data to the FormData object
    for (int i = 0; i < command.articleList.length; i++) {
      final article = command.articleList[i];
      formData.fields.addAll([
        MapEntry('articles[$i][articleId]', article!.articleId!),
        MapEntry('articles[$i][commandType]', article.commandType!),
        MapEntry('articles[$i][variantId]', article.variantId),
        MapEntry('articles[$i][quantity]', article.quantity.toString()),
        MapEntry('articles[$i][unityPrice]', article.unityPrice.toString()),
      ]);

      // Add the photo files to the FormData object
      if (article.files != null) {
        for (int j = 0; j < article.files!.length; j++) {
          final file = article.files![j];
          final originalFilename =
              basename(file.path); // Get the original filename
          final newFilename =
              'article${i + 1}_$originalFilename'; // Create the new filename
          final photo = await MultipartFile.fromFile(
            file.path,
            filename: newFilename, // Set the filename here
          );
          formData.files.add(MapEntry('photos', photo));
        }
      }
    }

    final response = await Dio().post(
      ApiConstance.createCommandes,
      // data: command.toJson(),
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
  Future<Unit> editCommand(CommandModel command) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    var formData = FormData();
    formData.fields.addAll([
      MapEntry('prixSoutraitant', command.prixSoutraitant.toString()),
      MapEntry('nomClient', command.nomClient),
      MapEntry('adresse', command.adresse),
      MapEntry('phoneNumber', command.phoneNumber.toString()),
      MapEntry('sommePaid', command.sommePaid.toString()),
    ]);

    if (command.noteClient != null) {
      formData.fields.add(MapEntry('noteClient', command.noteClient!));
    }
    if (command.page != null) {
      formData.fields.add(MapEntry('page', command.page!));
    }

    // Add the article data to the FormData object
    for (int i = 0; i < command.articleList.length; i++) {
      final article = command.articleList[i];
      formData.fields.addAll([
        MapEntry('articles[$i][articleId]', article!.articleId!),
        MapEntry('articles[$i][commandType]', article.commandType!),
        MapEntry('articles[$i][variantId]', article.variantId),
        MapEntry('articles[$i][quantity]', article.quantity.toString()),
        MapEntry('articles[$i][unityPrice]', article.unityPrice.toString()),
      ]);

      // Add the photo files to the FormData object
      if (article.files != null) {
        for (int j = 0; j < article.files!.length; j++) {
          final file = article.files![j];
          final originalFilename =
              basename(file.path); // Get the original filename
          final newFilename =
              'article${i + 1}_$originalFilename'; // Create the new filename
          final photo = await MultipartFile.fromFile(
            file.path,
            filename: newFilename,
          );
          formData.files.add(MapEntry('photos', photo));
        }
      }
      if (article.photos != null && article.photos!.isNotEmpty) {
        for (int j = 0; j < article.photos!.length; j++) {
          final photo = article.photos![j];
          formData.fields.add(MapEntry('articles[$i][photos][$j]', photo));
        }
      } else {
        formData.fields.add(MapEntry('articles[$i][photoshotos_0]', '[]'));
      }

      // Add the deletedPhotos list of strings to the FormData object
      if (article.deletedPhotos != null && article.deletedPhotos!.isNotEmpty) {
        for (int j = 0; j < article.deletedPhotos!.length; j++) {
          final deletedPhoto = article.deletedPhotos![j];
          formData.fields
              .add(MapEntry('articles[$i][deletedPhotos][$j]', deletedPhoto));
        }
      } else {
        formData.fields.add(MapEntry('articles[$i][deletedPhotos_0]', ''));
      }
      final deletedPhotos = article.deletedPhotos;

    }

    log(formData.toString());
    final response = await Dio().patch(
      ApiConstance.updateCommand(command.id!),
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
}
