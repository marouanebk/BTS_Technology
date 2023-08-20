import 'dart:developer';

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
              log("refreshy indicator");
              context.read<NotificationBloc>().add(GetNotificationsEvent());
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                          if (state.getNotificationsState ==
                              RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          } else if (state.getNotificationsState ==
                              RequestState.loaded) {
                            return ListView.separated(
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 7,
                              ),
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.getNotifications.length,
                              // itemCount: state.getArticles.length,
                              itemBuilder: (context, index) {
                                final reversedIndex =
                                    state.getNotifications.length - 1 - index;
                                return notificationItem(
                                    state.getNotifications[reversedIndex]);
                                // return notificationItem(
                                //     state.getNotifications[index]);
                              },
                            );
                          }
                          return Container();
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget notificationItem(item) {
    Color statusColor;
    Color bgColor;
    String keyword = '';
    String beforeKeyword = item.notification;
    String afterKeyword = '';

    if (item.notification.contains('Numero erroné')) {
      statusColor = Colors.red;
      bgColor = const Color.fromRGBO(255, 68, 68, 0.1);
      keyword = 'Numero erroné';
    } else if (item.notification.contains('Ne répond pas')) {
      statusColor = Colors.red;
      bgColor = const Color.fromRGBO(255, 68, 68, 0.1);
      keyword = 'Ne répond pas';
    } else if (item.notification.contains('Annulé')) {
      statusColor = Colors.red;
      bgColor = const Color.fromRGBO(255, 68, 68, 0.1);
      keyword = 'Annulé';
    } else if (item.notification.contains('En attente de confirmation')) {
      statusColor = Colors.red;
      bgColor = const Color.fromRGBO(255, 68, 68, 0.1);
      keyword = 'En attente de confirmation';
    } else if (item.notification.contains('Pas confirmé')) {
      statusColor = Colors.red;
      bgColor = const Color.fromRGBO(255, 68, 68, 0.1);
      keyword = 'Pas confirmé';
    } else if (item.notification.contains('Retourné')) {
      statusColor = Colors.red;
      bgColor = const Color.fromRGBO(255, 68, 68, 0.1);
      keyword = 'Retourné';
    } else if (item.notification.contains('Confirmé')) {
      statusColor = const Color(0xFFFF9F00);
      bgColor = const Color.fromRGBO(255, 159, 0, 0.1);
      keyword = 'Confirmé';
    } else if (item.notification.contains('Préparé')) {
      statusColor = const Color(0xFFFF9F00);
      bgColor = const Color.fromRGBO(255, 159, 0, 0.1);
      keyword = 'Préparé';
    } else if (item.notification.contains('Encaissé')) {
      statusColor = Colors.blue;
      bgColor = const Color.fromRGBO(0, 102, 255, 0.1);
      keyword = 'Encaissé';
    } else if (item.notification.contains('Expidié')) {
      statusColor = Colors.green;
      bgColor = const Color.fromRGBO(7, 176, 24, 0.1);
      keyword = 'Expidié';
    } else {
      statusColor = Colors.white;
      bgColor = Colors.black;
      keyword = '';
    }

    if (keyword.isNotEmpty) {
      int indexKeywordStart = item.notification.indexOf(keyword);
      int indexKeywordEnd = indexKeywordStart + keyword.length;
      beforeKeyword = item.notification.substring(0, indexKeywordStart);
      afterKeyword = item.notification.substring(indexKeywordEnd);
    }
    beforeKeyword = beforeKeyword.replaceAll('(', '').replaceAll(')', '');
    afterKeyword = afterKeyword.replaceAll('(', '').replaceAll(')', '');

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
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: beforeKeyword,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
              ),
              if(keyword.isNotEmpty)
              WidgetSpan(
                child: Container(
                  padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: bgColor,
                  ),
                  child: Text(
                    keyword,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
              TextSpan(
                text: afterKeyword,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
              ),
            ],
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
