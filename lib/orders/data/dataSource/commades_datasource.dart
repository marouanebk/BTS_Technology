import 'dart:developer';

import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }

  @override
  Future<Unit> createCommand(CommandModel command) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().post(
      ApiConstance.createCommandes,
      data: command.toJson(),
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
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['err']));
    }
  }

  @override
  Future<Unit> editCommand(CommandModel command) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().post(
      ApiConstance.createCommandes,
      data: command.toJson(),
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
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['err']));
    }
  }
}
