
import 'package:bts_technologie/notifications/domaine/Entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required String notification,
    required String time,
  }) : super(
          notification: notification,
          time: time,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      time: json["time"],
      notification: json["notification"],
    );
  }
}
