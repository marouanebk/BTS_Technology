import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String notification;
  final String time;

  const NotificationEntity({
    required this.notification,
    required this.time,
  });

  @override
  List<Object?> get props => [
        notification,
        time,
      ];
}
