import 'dart:developer';

import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseCommandRemoteDatasource {
  Future<List<CommandModel>> getCommandes();
}

class CommandRemoteDataSource extends BaseCommandRemoteDatasource {
  @override
   Future<List<CommandModel>> getCommandes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userid");

    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGNkNTczM2NhNjU1NGZmNjZmNTUyMjgiLCJpYXQiOjE2OTEyMjkxNTYsImV4cCI6MTY5MzgyMTE1Nn0.DS6Ygk1qG8prSw5SppyqQ4LZGT_zmWZ-_Eb0cL496Gc";
    final response = await Dio().get(ApiConstance.getArticles,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    log("response");
    if (response.statusCode == 200) {
      return List<CommandModel>.from(
          (response.data as List).map((e) => CommandModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }
}
