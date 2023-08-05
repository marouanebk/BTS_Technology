import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:bts_technologie/mainpage/data/Models/livreur_model.dart';
import 'package:bts_technologie/mainpage/data/Models/page_model.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:dio/dio.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAccountRemoteDateSource {
  Future<List<FacePage>> getPages();
  Future<List<LivreurModel>> getLivreurs();
}

class AccountRemoteDataSource extends BaseAccountRemoteDateSource {
  @override
  Future<List<FacePage>> getPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getAllPages,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    log(response.statusCode.toString());
  
    if (response.statusCode == 200) {
      
      return List<PageModel>.from((response.data as List).map(
        (e) => PageModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }

  @override
  Future<List<LivreurModel>> getLivreurs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getAllLivreurs,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    log("response");
    if (response.statusCode == 200) {
      return List<LivreurModel>.from((response.data as List).map(
        (e) => LivreurModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }
}
