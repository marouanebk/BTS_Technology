import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/notifications/domaine/Entities/notification_entity.dart';
import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  final List<NotificationEntity> getNotifications;
  final RequestState getNotificationsState;
  final String getNotificationsmessage;
  

  const NotificationState({
    this.getNotifications = const [],
    this.getNotificationsState = RequestState.loading,
    this.getNotificationsmessage = "",
    //

  });

  NotificationState copyWith({
    List<NotificationEntity>? getNotifications,
    RequestState? getNotificationsState,
    String? getNotificationsmessage,
    //

  }) {
    return NotificationState(
      getNotifications: getNotifications ?? this.getNotifications,
      getNotificationsState: getNotificationsState ?? this.getNotificationsState,
      getNotificationsmessage: getNotificationsmessage ?? this.getNotificationsmessage,

    );
    //
  }

  @override
  List<Object?> get props => [
        getNotifications,
        getNotificationsState,
        getNotificationsmessage,

      ];
}
