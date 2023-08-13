import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:bts_technologie/authentication/data/models/user_model.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseUserRemoteDateSource {
  Future<UserModel> createUser(UserModel userModel);
  Future<UserModel> loginUser(UserModel userModel);
  Future<bool> logOutUser();
  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSource extends BaseUserRemoteDateSource {
  @override
  Future<UserModel> createUser(UserModel userModel) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final response = await Dio().post(
      ApiConstance.signup,
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
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('fullname', userModel.fullname!);
      // await prefs.setString('email', userModel.email);
      // await prefs.setString('userid', userModel.userid!);
      // await prefs.setInt('is logged in', 1);

      // return UserModel.fromJson(response.data['userid']);
      return UserModel.fromJson(response.data['user']);
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
  Future<UserModel> loginUser(UserModel userModel) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final response = await Dio().post(
      ApiConstance.login,
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
      await prefs.setInt('is logged in', 1);
      await prefs.setString("id", response.data['user']["_id"]);
      await prefs.setString("token", response.data['token']);
      await prefs.setString("type", response.data['user']["role"]);

      return UserModel.fromJson(response.data['user']);
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
  Future<bool> logOutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('is logged in', 0);
    await prefs.remove("fullanme");
    await prefs.remove('email');
    await prefs.remove("userid");
    await prefs.remove('type');

    return true;
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getAllUsers,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      return List<UserModel>.from((response.data as List).map(
        (e) => UserModel.fromJson(e),
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
