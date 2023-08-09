import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersInfoPageVIew extends StatefulWidget {
  final List<User> users;
  const UsersInfoPageVIew({required this.users, super.key});

  @override
  State<UsersInfoPageVIew> createState() => _UsersInfoPageVIewState();
}

class _UsersInfoPageVIewState extends State<UsersInfoPageVIew> {
  List<bool> isUserDropDownVisibleList = List.generate(15, (index) => false);
  bool _isPasswordVisible = false; // Add this variable

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  "Admins de l'application ",
                  style: TextStyle(
                    color: Color(
                        0xFF9F9F9F), // Replace with your custom color if needed
                    fontFamily: "Inter", // Replace with the desired font family
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
                  itemCount:
                      widget.users.where((user) => user.role == "admin").length,
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
                const Text(
                  "Admins des pages ",
                  style: TextStyle(
                    color: Color(
                        0xFF9F9F9F), // Replace with your custom color if needed
                    fontFamily: "Inter", // Replace with the desired font family
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
                const Text(
                  "Responsable Logistics ",
                  style: TextStyle(
                    color: Color(
                        0xFF9F9F9F), // Replace with your custom color if needed
                    fontFamily: "Inter", // Replace with the desired font family
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
                const Text(
                  "Responsable Finances ",
                  style: TextStyle(
                    color: Color(
                        0xFF9F9F9F), // Replace with your custom color if needed
                    fontFamily: "Inter", // Replace with the desired font family
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
            ),
          ),
        );
      }),
    );
  }

  Widget userContainerView(User user, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isUserDropDownVisibleList[index] = !isUserDropDownVisibleList[index];
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(5),
            bottom: isUserDropDownVisibleList[index]
                ? const Radius.circular(
                    0) // Remove bottom-left and bottom-right radius
                : const Radius.circular(
                    5), // Keep radius when dropdown is not visible
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
                    height: 5,
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "mot de passe: ",
                          style: TextStyle(
                            color: Color(0xFF9F9F9F),
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              _isPasswordVisible ? user.password : " ********",
                          style: const TextStyle(
                            color: Color(0xFF9F9F9F),
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 4,
                        )),
                        WidgetSpan(
                          child: InkWell(
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFF9F9F9F),
                              size: 16,
                            ),
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //drop down
            if (isUserDropDownVisibleList[index]) usersContainerDropDown(),
          ],
        ),
      ),
    );
  }

  Widget usersContainerDropDown() {
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
              onPressed: () {},
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
              onPressed: () {},
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
