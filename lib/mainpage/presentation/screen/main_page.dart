import 'dart:developer';
import 'package:bts_technologie/authentication/presentation/screen/login_page.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/command_stats_entity.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:bts_technologie/mainpage/presentation/screen/admin_stats_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/clients_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/params_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(initialPage: 0);
  int pageindex = 0;

  Map<int, String> frenchMonthAbbreviations = {
    1: 'jan',
    2: 'fév',
    3: 'mar',
    4: 'avr',
    5: 'mai',
    6: 'jun',
    7: 'jui',
    8: 'aoû',
    9: 'sep',
    10: 'oct',
    11: 'nov',
    12: 'déc',
  };

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AccountBloc>()
        ..add(GetAdminUserStatsEvent())
        ..add(GetCommandsStatsEvent())
        ..add(GetUserInfoEvent()),
      child: Builder(
        builder: (context) {
          return Builder(builder: (context) {
            return BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          expandedHeight: 200, // Adjust this value as needed
                          floating: false,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            background: _topContainer(context, state),
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _topContainer(context),
                          Center(
                            child: Container(
                              height: 3,
                              width: 43,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(22),
                                ),
                              ),
                            ),
                          ),
                          if (state.getCommandsStatsState ==
                              RequestState.loading)
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          if (state.getCommandsStatsState == RequestState.error)
                            Text(
                              state.getAdminUserStatsmessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          if (state.getCommandsStatsState ==
                              RequestState.loaded) ...[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var i = 0;
                                      i < state.getCommandsStats.length;
                                      i++) ...[
                                    dateFilter(
                                        i,
                                        frenchMonthAbbreviations[
                                            state.getCommandsStats[i].month]),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 330,
                                  child: PageView(
                                    controller: controller,
                                    onPageChanged: (index) {
                                      log("page ${index + 1} ");
                                      pageindex = index;
                                      setState(() {
                                        index;
                                      });
                                    },
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      for (var i = 0;
                                          i < state.getCommandsStats.length;
                                          i++) ...[
                                        _commandsStats(
                                            state.getCommandsStats[i]),
                                        // const SizedBox(height: 24),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                if (state.getAdminUserStatsState ==
                                    RequestState.loading)
                                  const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    ),
                                  ),
                                if (state.getAdminUserStatsState ==
                                    RequestState.error)
                                  Text(
                                    state.getAdminUserStatsmessage,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                if (state.getAdminUserStatsState ==
                                    RequestState.loaded)
                                  usersList(state.getAdminUserStats),
                                // usersList(),
                                const SizedBox(
                                  height: 30,
                                ),
                                pagesList(),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }

  Widget pagesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pages",
          style: TextStyle(
            color:
                Color(0xFF9F9F9F), // Replace with your custom color if needed
            fontFamily: "Inter", // Replace with the desired font family
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 1.0, // Default line height is normal (1.0)
          ),
          textAlign: TextAlign.right,
        ),
        ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => const SizedBox(
            height: 14,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return pageContainer();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            "voir tous",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color:
                  Color(0xFF9F9F9F), // Replace with your custom color if needed
              fontFamily: "Inter", // Replace with the desired font family
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              height: 1.0, // Default line height is normal (1.0)
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget pageContainer() {
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
          const Text(
            "Mouloud Bari",
            style: TextStyle(
              color: Color(0xFF111111),
              fontFamily: "Inter",
              fontSize: 18,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "15,000DA",
                style: TextStyle(
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
              smallRichText(
                  "82", 'assets/images/navbar/commandes_activated.svg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget usersList(users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "admins",
          style: TextStyle(
            color:
                Color(0xFF9F9F9F), // Replace with your custom color if needed
            fontFamily: "Inter", // Replace with the desired font family
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 1.0, // Default line height is normal (1.0)
          ),
          textAlign: TextAlign.right,
        ),
        ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => const SizedBox(
            height: 14,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: users.length > 4 ? 4 : users.length,
          itemBuilder: (context, index) {
            return userContainer(users[index]);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (_) => AdminUsersStatsPage(users: users),
                ),
              );
            },
            child: const Text(
              "voir tous",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color(
                    0xFF9F9F9F), // Replace with your custom color if needed
                fontFamily: "Inter", // Replace with the desired font family
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0, // Default line height is normal (1.0)
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
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

  Widget _commandsStats(CommandStatsEntity command) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          // height: 323,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                offset: Offset(0, 0),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${command.totalCommandes} Commandes",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (_) => const ClientsPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "voir les clients",
                      style: TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              for (var i = 0; i < command.status.length; i++)
                _progressItem(command.status[i].name, command.status[i].count,
                    command.status[i].percentage.toInt()),
              // _progressItem("Ne répond pas", 15),
              // _progressItem("Numero erroné", 15),
              // _progressItem("Annulé", 15),
              // _progressItem("Pas confirmé", 15),
              // _progressItem("Confirmé", 15),
              // _progressItem("Préparé", 15),
              // _progressItem("Expidié", 15),
              // _progressItem("Encaissé", 15),
              // _progressItem("Retourné", 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressItem(String label, int number, int progress) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF9F9F9F),
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ),
          LinearPercentIndicator(
            width: 100.0,
            lineHeight: 8.0,
            percent: progress / 100,
            progressColor: Colors.black,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 50, // adjust this value to your needs
            child: Text(
              '$number - $progress%',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9F9F9F),
                  fontFamily: 'Inter'),
            ),
          ),
          // const SizedBox(width: 8),
          // Text(
          //   '$number - $progress%',
          //   style: const TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.w400,
          //       color: Color(0xFF9F9F9F),
          //       fontFamily: 'Inter'),
          // ),
        ],
      ),
    );
  }

  Widget _topContainer(context, state) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/homebg.png",
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/logout_admin.svg',
                        width: 20,
                        height: 30,
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setInt('is logged in', 0);
                        await prefs.remove("id");
                        await prefs.remove('type');
                        await prefs.remove("token");
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginPage();
                            },
                          ),
                          (_) => false,
                        );
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/setting_admin.svg',
                        width: 20,
                        height: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/adminParams');

                        // Navigator.of(context, rootNavigator: true).push(
                        //   MaterialPageRoute(
                        //     builder: (_) => const AdminParams(),
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state.getUserInfoState == RequestState.loaded) {
                    return Column(
                      children: [
                        const Text(
                          "bienvenue",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF), // White color (#FFF)
                            fontFamily: 'Inter', // Font family
                            fontSize: 16, // Font size
                            fontStyle: FontStyle.normal, // Font style
                            fontWeight: FontWeight.w400, // Font weight
                            height: 1.2, // Line height
                          ),
                        ),
                        Text(
                          state.getUserInfo!.fullname!,
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF), // White color (#FFF)
                            fontFamily: 'Inter', // Font family
                            fontSize: 28, // Font size
                            fontStyle: FontStyle.normal, // Font style
                            fontWeight: FontWeight.w600, // Font weight
                            height: 1.2, // Line height
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          height: 20,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(" @${state.getUserInfo!.username}"),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state.getUserInfoState == RequestState.loading) {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              // const Text(
              //   "bienvenue",
              //   style: TextStyle(
              //     color: Color(0xFFFFFFFF), // White color (#FFF)
              //     fontFamily: 'Inter', // Font family
              //     fontSize: 16, // Font size
              //     fontStyle: FontStyle.normal, // Font style
              //     fontWeight: FontWeight.w400, // Font weight
              //     height: 1.2, // Line height
              //   ),
              // ),
              // const Text(
              //   "Aziz Berrazouane",
              //   style: TextStyle(
              //     color: Color(0xFFFFFFFF), // White color (#FFF)
              //     fontFamily: 'Inter', // Font family
              //     fontSize: 28, // Font size
              //     fontStyle: FontStyle.normal, // Font style
              //     fontWeight: FontWeight.w600, // Font weight
              //     height: 1.2, // Line height
              //   ),
              // ),
              // const SizedBox(
              //   height: 6,
              // ),
              // Container(
              //   height: 20,
              //   width: 70,
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(25),
              //     ),
              //     color: Colors.white,
              //   ),
              //   child: const Center(
              //     child: Text(" @aziz"),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dateFilter(number, text) {
    return GestureDetector(
      onTap: () {
        controller.animateToPage(number,
            duration: const Duration(seconds: 1), curve: Curves.ease);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35)),
          border: Border.all(
            color: const Color(0xFF9F9F9F),
          ),
          color: number == pageindex ? Colors.black : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            // fontFamily: AppFonts.mainFont,
            fontWeight: FontWeight.w500,
            color: number == pageindex ? Colors.white : const Color(0xFF9F9F9F),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
