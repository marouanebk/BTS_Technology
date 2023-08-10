import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/notifications/domaine/Entities/notification_entity.dart';
import 'package:bts_technologie/notifications/domaine/Repository/base_notification_repo.dart';
import 'package:dartz/dartz.dart';

class GetNotificationsUseCase {
  final BaseNotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<Either<Failure, List<NotificationEntity>>> call() async {
    return await repository.getNotifications();
  }
}
