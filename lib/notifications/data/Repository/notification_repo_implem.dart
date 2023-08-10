import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:bts_technologie/notifications/data/dataSource/base_notifications_datasource.dart';
import 'package:bts_technologie/notifications/domaine/Entities/notification_entity.dart';
import 'package:bts_technologie/notifications/domaine/Repository/base_notification_repo.dart';
import 'package:dartz/dartz.dart';

class NotificationsRepository implements BaseNotificationRepository {
  final BaseNotificationsRemoteDateSource baseNotificationsRemoteDateSource;

  NotificationsRepository(this.baseNotificationsRemoteDateSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final result = await baseNotificationsRemoteDateSource.getNotifications();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
