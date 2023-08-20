import 'package:bts_technologie/authentication/presentation/screen/login_page.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/mainpage/presentation/components/search_container.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/components/factor_command_container.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_bloc.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_event.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_state.dart';
import 'package:bts_technologie/orders/presentation/screen/new_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersPage extends StatefulWidget {
  final String role;
  const OrdersPage({required this.role, super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final controller = PageController(initialPage: 0);
  String selectedStatus = 'Tous'; // Initialize with 'Tous'

  int pageindex = 0;
  String searchQuery = ''; // Add this line

  // List<bool> isDropDownVisibleList = List.generate(15, (index) => false);
  Map<String, List<bool>> isDropDownVisibleMap = {};
  bool initList = false;

  List<String> statusListAdministrator = [
    'Tous',
    'Téléphone éteint',
    'Ne répond pas',
    'Numero erroné',
    'Annulé',
    'Pas confirmé',
    'Confirmé',
    'Annulé',
    'Préparé',
    'Expidié',
    'Encaissé',
    'Retourné',
  ];

  List<String> statusListLogistics = [
    'Tous',
    'Téléphone éteint',
    'Ne répond pas',
    'Numero erroné',
    'Annulé',
    'Pas confirmé',
    'Confirmé',
    'Annulé',
    'Préparé',
    'Expidié',
  ];

  List<String> financierStatusList = [
    'Tous',
    'Expidié',
    'Encaissé',
    'Retourné',
  ];

  List<String> getStatusListBasedOnRole(String role) {
    if (role == 'admin' || role == 'pageAdmin') {
      return statusListAdministrator;
    } else if (role == 'financier') {
      return financierStatusList;
    } else if (role == 'logistics') {
      return statusListLogistics;
    } else {
      return []; // Return an empty list or handle other cases as needed
    }
  }

// In

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void resetDropDownVisibility() {
  isDropDownVisibleMap.forEach((key, value) {
    for (int i = 0; i < value.length; i++) {
      value[i] = false;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    List<String> currentStatusList = getStatusListBasedOnRole(widget.role);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CommandBloc>()..add(GetCommandesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<AccountBloc>()..add(GetUserInfoEvent()),
        ),
      ],
      child: Builder(builder: (context) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              resetDropDownVisibility();
              context.read<CommandBloc>().add(GetCommandesEvent());
            },
            child: Scaffold(
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  screenHeader("Commandes",
                      'assets/images/navbar/commandes_activated.svg'),
                  const SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: searchContainer("Chercher une commande", (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    }),
                  ),
                  BlocListener<AccountBloc, AccountState>(
                    listener: (context, state) async {
                      if (state.getUserInfoState == RequestState.error) {
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
                      }
                    },
                    child: const SizedBox(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children:
                            List.generate(currentStatusList.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child:
                                statusFilter(index, currentStatusList[index]),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CommandBloc, CommandesState>(
                    builder: (context, state) {
                      if (state.getCommandesState == RequestState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                      if (state.getCommandesState == RequestState.error) {
                        return Text(
                          state.getCommandesmessage,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      if (state.getCommandesState == RequestState.loaded) {
                        List<Command> filteredCommands = state.getCommandes
                            .where((command) =>
                                (selectedStatus == 'Tous' ||
                                    command.status == selectedStatus) &&
                                (searchQuery.isEmpty ||
                                    command.phoneNumber
                                        .toString()
                                        .contains(searchQuery)))
                            .toList();

                        // Group and display filtered data
                        Map<String, List<Command>> groupedData = {};
                        // for (Command command in state.getCommandes) {

                        for (Command command in filteredCommands) {
                          if (!groupedData.containsKey(command.date)) {
                            groupedData[command.date!] = [];
                          }
                          groupedData[command.date]?.add(command);
                        }
                        if (initList == false) {
                          for (String date in groupedData.keys) {
                            isDropDownVisibleMap[date] = List.generate(
                                groupedData[date]!.length, (index) => false);
                          }
                          initList = true;
                        }

                        return Expanded(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (String date in groupedData.keys) ...[
                                    Text(date),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 14,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: groupedData[date]!.length,
                                      itemBuilder: (context, index) {
                                        Command command =
                                            groupedData[date]![index];
                                        return commandeCard(command, index);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                  const SizedBox(
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
              floatingActionButton: widget.role != 'logistics'
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 20),
                        child: Container(
                          height: 76,
                          width: 76,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AddOrderPage(role: widget.role),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 35,
                              ),
                              color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        );
      }),
    );
  }

  Widget commandeCard(Command command, int index) {
    Color statusColor;
    Color bgColor;
    String? date = command.date;

    if (command.status == 'Numero erroné' ||
        command.status == 'Ne répond pas' ||
        command.status == 'Annulé' ||
        command.status == 'En attente de confirmation' ||
        command.status == 'Pas confirmé' ||
        command.status == 'Retourné' ||
        command.status == 'Téléphone éteint') {
      statusColor = Colors.red;
      bgColor = const Color.fromRGBO(255, 68, 68, 0.1);
    } else if (command.status == 'Confirmé' || command.status == 'Préparé') {
      statusColor = const Color(0xFFFF9F00);
      bgColor = const Color.fromRGBO(255, 159, 0, 0.1);
    } else if (command.status == 'Encaissé') {
      statusColor = Colors.blue;
      bgColor = const Color.fromRGBO(0, 102, 255, 0.1);
    } else if (command.status == 'Expidié') {
      statusColor = Colors.green;
      bgColor = const Color.fromRGBO(7, 176, 24, 0.1);
    } else {
      statusColor = Colors.white;
      bgColor = Colors.black;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          isDropDownVisibleMap[date]![index] =
              !isDropDownVisibleMap[date]![index];
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
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
              height: 61,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Com N° ${command.comNumber}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: bgColor,
                      ),
                      child: Text(
                        command.status!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: statusColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (isDropDownVisibleMap[date]![index])
              FactorCommandContainer(
                role: widget.role,
                command: command,
              ),
          ],
        ),
      ),
    );
  }

  Widget statusFilter(number, text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = text;
          pageindex = number;
        });
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
