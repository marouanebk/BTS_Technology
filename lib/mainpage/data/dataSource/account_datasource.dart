import 'dart:developer';

import 'package:bts_technologie/authentication/data/models/user_model.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/mainpage/data/Models/command_stats_model.dart';
import 'package:bts_technologie/mainpage/data/Models/entreprise_model.dart';
import 'package:bts_technologie/mainpage/data/Models/livreur_model.dart';
import 'package:bts_technologie/mainpage/data/Models/page_model.dart';
import 'package:bts_technologie/mainpage/data/Models/user_stat_model.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:dio/dio.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAccountRemoteDateSource {
  Future<List<FacePage>> getPages();
  Future<List<LivreurModel>> getLivreurs();
  Future<List<CommandStatsModel>> getCommandStats();
  Future<EntrepriseModel> getEntrepriseInfo();
  Future<List<UserStatModel>> getUsersStats();
  Future<UserModel> getUserInfo();
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

  @override
  Future<UserModel> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final id = prefs.getString("id");

    final response = await Dio().get(
      ApiConstance.getUser(id!),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['error']));
    }
  }

  @override
  Future<EntrepriseModel> getEntrepriseInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await Dio().get(
      ApiConstance.getEntrepriseApi,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      return EntrepriseModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['error']));
    }
  }

  @override
  Future<List<CommandStatsModel>> getCommandStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getCommandesStatsForAdmin,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      return List<CommandStatsModel>.from((response.data as List).map(
        (e) => CommandStatsModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }

  @override
  Future<List<UserStatModel>> getUsersStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getAdminUserStats,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      return List<UserStatModel>.from((response.data as List).map(
        (e) => UserStatModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }
}
