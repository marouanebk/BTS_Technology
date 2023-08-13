
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/notifications/presentation/controller/notification_bloc/notification_bloc.dart';
import 'package:bts_technologie/notifications/presentation/controller/notification_bloc/notification_event.dart';
import 'package:bts_technologie/notifications/presentation/controller/notification_bloc/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationBloc>()..add(GetNotificationsEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              // Reload the page here
              // For example, you can call a method on your bloc to fetch new data
              context.read<NotificationBloc>().add(GetNotificationsEvent());
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    screenHeader("Notifications",
                        'assets/images/navbar/notifications_activated.svg'),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<NotificationBloc, NotificationState>(
                        builder: (context, state) {
                      if (state.getNotificationsState == RequestState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else if (state.getNotificationsState ==
                          RequestState.loaded) {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 7,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.getNotifications.length,
                          // itemCount: state.getArticles.length,
                          itemBuilder: (context, index) {
                            return notificationItem(
                                state.getNotifications[index]);
                          },
                        );
                      }
                      return Container();
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget notificationItem(item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.time,
          style: const TextStyle(
            color: Color(0xFF9F9F9F),
            fontFamily: 'Inter',
            fontSize: 12,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          item.notification,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Inter',
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          width: double.infinity,
          child: Divider(
            height: 2,
            thickness: 2,
            color: Color(0xFFECECEC),
          ),
        ),
      ],
    );
  }
}
