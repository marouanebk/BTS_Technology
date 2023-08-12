import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/notifications/data/Models/notification_model.dart';
import 'package:dio/dio.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseNotificationsRemoteDateSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationsRemoteDataSource extends BaseNotificationsRemoteDateSource {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getNotificaitonsApi,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      return List<NotificationModel>.from((response.data as List).map(
        (e) => NotificationModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['message']));
    }
  }
}
