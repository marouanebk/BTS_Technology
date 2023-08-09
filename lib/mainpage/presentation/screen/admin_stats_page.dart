import 'package:bts_technologie/mainpage/domaine/Entities/user_stat_entity.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/mainpage/presentation/components/search_container.dart';
import 'package:flutter/material.dart';

class AdminUsersStatsPage extends StatefulWidget {
  final List<UserStatEntity> users;
  const AdminUsersStatsPage({required this.users, super.key});

  @override
  State<AdminUsersStatsPage> createState() => _AdminUsersStatsPageState();
}

class _AdminUsersStatsPageState extends State<AdminUsersStatsPage> {
  String searchQuery = ''; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(titleText: "List des admins"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // searchContainer("Chercher un admin ", (query) {
              //   setState(() {
              //     searchQuery = query;
              //   });
              // }),
              const SizedBox(
                height: 30,
              ),
              ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 14,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.users.length,
                itemBuilder: (context, index) {
                  return userContainer(widget.users[index]);
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userContainer(user) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white, // Replace with your custom color if needed
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 0),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullname,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "@${user.username}",
                style: const TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontFamily: "Inter",
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${user.totalMoneyMade} DA",
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontFamily: "Inter",
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              smallRichText(user.numberOfCommands.toString(),
                  'assets/images/navbar/commandes_activated.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
