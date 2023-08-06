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
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getCommandes,
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
