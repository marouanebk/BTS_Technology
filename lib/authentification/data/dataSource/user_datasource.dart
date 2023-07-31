import 'dart:developer';

import 'package:bts_technologie/authentification/data/Models/user_model.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseUserRemoteDateSource {
  Future<UserModel> signupUser(UserModel userModel);
  Future<UserModel> loginUser(UserModel userModel);
  Future<bool> logOutUser();
}

class UserRemoteDataSource extends BaseUserRemoteDateSource {
  @override
  Future<UserModel> signupUser(UserModel userModel) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final response = await Dio().post(
      "http://10.0.2.2:4000/users/register",
      data: userModel.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: requestHeaders,
      ),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullname', userModel.fullname);
      await prefs.setString('email', userModel.email);
      // await prefs.setString('userid', userModel.userid!);
      await prefs.setInt('is logged in', 1);

      return response.data;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }

  @override
  Future<UserModel> loginUser(UserModel userModel) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    final response = await Dio().post(
      "http://10.0.2.2:4000/users/login",
      data: userModel.toJson(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: requestHeaders,
      ),
    );
    log(response.data['message'].toString());

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('is logged in', 1);
      await prefs.setString(
          'fullname', response.data["data"]['fullname'].toString());
      await prefs.setString('email', response.data["data"]['email'].toString());

      await prefs.setString(
          "userid", response.data["data"]['userid'].toString());
      return response.data;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }

  @override
  Future<bool> logOutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('is logged in', 0);
    await prefs.remove("fullanme");
    await prefs.remove('email');
    await prefs.remove("userid");
    await prefs.remove('type');

    return true;
  }
}
