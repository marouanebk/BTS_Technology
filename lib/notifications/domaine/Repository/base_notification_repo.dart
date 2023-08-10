import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/notifications/domaine/Entities/notification_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BaseNotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

}
