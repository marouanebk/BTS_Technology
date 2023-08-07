import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/finances/data/model/finance_model.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseFinanceRemoteDateSource {
  Future<List<FinanceModel>> getFinances();
}

class FinanceRemoteDataSource extends BaseFinanceRemoteDateSource {
  @override
  Future<List<FinanceModel>> getFinances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getArticles,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    log("response");
    if (response.statusCode == 200) {
      return List<FinanceModel>.from((response.data as List).map(
        (e) => FinanceModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }
}
