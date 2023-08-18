import 'dart:developer';

import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersInfoPageVIew extends StatefulWidget {
  final List<User> users;
  final List<FacePage> pages;

  const UsersInfoPageVIew(
      {required this.pages, required this.users, super.key});

  @override
  State<UsersInfoPageVIew> createState() => _UsersInfoPageVIewState();
}

class _UsersInfoPageVIewState extends State<UsersInfoPageVIew> {
  List<bool> isAdminDropDownVisibleList = List.generate(45, (index) => false);
  List<bool> isPageAdminDropDownVisibleList =
      List.generate(45, (index) => false);
  List<bool> isLogisticsDropDownVisibleList =
      List.generate(45, (index) => false);
  List<bool> isFinancierDropDownVisibleList =
      List.generate(45, (index) => false);

  @override
  Widget build(BuildContext context) {
    int financierCount =
        widget.users.where((user) => user.role == "financier").length;
    int logisticsCount =
        widget.users.where((user) => user.role == "logistics").length;
    int pageAdminCount =
        widget.users.where((user) => user.role == "pageAdmin").length;
    int adminCount = widget.users.where((user) => user.role == "admin").length;

    return BlocProvider(
      create: (context) => sl<AccountBloc>()..add(GetAllAccountsEvent()),
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                if (adminCount > 0) ...[
                  const Text(
                    "Admins de l'application ",
                    style: TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.users
                        .where((user) => user.role == "admin")
                        .length,
                    itemBuilder: (context, index) {
                      var usersWithRole = widget.users
                          .where((user) => user.role == "admin")
                          .toList();

                      return userContainerView(usersWithRole[index], index);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
                if (pageAdminCount > 0) ...[
                  const Text(
                    "Admins des pages ",
                    style: TextStyle(
                      color: Color(
                          0xFF9F9F9F), // Replace with your custom color if needed
                      fontFamily:
                          "Inter", // Replace with the desired font family
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 1.0, // Default line height is normal (1.0)
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.users
                        .where((user) => user.role == "pageAdmin")
                        .length,
                    itemBuilder: (context, index) {
                      var usersWithRole = widget.users
                          .where((user) => user.role == "pageAdmin")
                          .toList();

                      return userContainerView(usersWithRole[index], index);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
                if (logisticsCount > 0) ...[
                  const Text(
                    "Responsable Logistics ",
                    style: TextStyle(
                      color: Color(
                          0xFF9F9F9F), // Replace with your custom color if needed
                      fontFamily:
                          "Inter", // Replace with the desired font family
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 1.0, // Default line height is normal (1.0)
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.users
                        .where((user) => user.role == "logistics")
                        .length,
                    itemBuilder: (context, index) {
                      var usersWithRole = widget.users
                          .where((user) => user.role == "logistics")
                          .toList();

                      return userContainerView(usersWithRole[index], index);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
                if (financierCount > 0) ...[
                  const Text(
                    "Responsable Finances ",
                    style: TextStyle(
                      color: Color(
                          0xFF9F9F9F), // Replace with your custom color if needed
                      fontFamily:
                          "Inter", // Replace with the desired font family
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      height: 1.0, // Default line height is normal (1.0)
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.users
                        .where((user) => user.role == "financier")
                        .length,
                    itemBuilder: (context, index) {
                      var usersWithRole = widget.users
                          .where((user) => user.role == "financier")
                          .toList();

                      return userContainerView(usersWithRole[index], index);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget userContainerView(User user, int index) {
    List<bool> dropDownList;

    switch (user.role) {
      case "admin":
        dropDownList = isAdminDropDownVisibleList;
        break;
      case "pageAdmin":
        dropDownList = isPageAdminDropDownVisibleList;
        break;
      case "logistics":
        dropDownList = isLogisticsDropDownVisibleList;
        break;
      case "financier":
        dropDownList = isFinancierDropDownVisibleList;
        break;
      default:
        dropDownList = [];
        break;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          dropDownList[index] = !dropDownList[index];
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(5),
            bottom: dropDownList[index]
                ? const Radius.circular(0)
                : const Radius.circular(5),
          ),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 0),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.only(left: 15, top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: user.fullname,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                        ),
                        TextSpan(
                          text: " @${user.username}",
                          style: const TextStyle(
                            color: Color(0xFF9F9F9F),
                            fontFamily: "Inter",
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
                ],
              ),
            ),
            //drop down
            if (dropDownList[index]) usersContainerDropDown(user, context),
          ],
        ),
      ),
    );
  }

  Widget usersContainerDropDown(User user, context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 50, // Set the height to 50
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFF111111),
                width: 1,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    '/editUser',
                    arguments: {'pages': widget.pages, 'user': user}).then((_) {
                  BlocProvider.of<AccountBloc>(context)
                      .add(GetAllAccountsEvent());
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text(
                "Modifier Le compte",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 50, // Set the height to 50
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final token = prefs.getString("token");
                final response =
                    await Dio().delete(ApiConstance.deleteUser(user.id!),
                        options: Options(
                          headers: {
                            "Authorization": "Bearer $token",
                          },
                        ));
                if (response.statusCode == 200) {
                  Navigator.of(context).pushReplacementNamed('/accountManager');
                } else {
                  log("failed");
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                "Supprimer le compte",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
