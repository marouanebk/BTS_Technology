import 'dart:async';

import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/notifications/domaine/UseCase/get_notifications_usecase.dart';
import 'package:bts_technologie/notifications/presentation/controller/notification_bloc/notification_event.dart';
import 'package:bts_technologie/notifications/presentation/controller/notification_bloc/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationBloc(this.getNotificationsUseCase)
      : super(const NotificationState()) {
    on<GetNotificationsEvent>(_getNotificationsEvent);
  }
  FutureOr<void> _getNotificationsEvent(
      GetNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(getNotificationsState: RequestState.loading));
    final result = await getNotificationsUseCase();
    result.fold(
        (l) => emit(state.copyWith(
            getNotificationsState: RequestState.error,
            getNotificationsmessage: l.message)),
        (r) => emit(state.copyWith(
            getNotifications: r, getNotificationsState: RequestState.loaded)));
  }
}
