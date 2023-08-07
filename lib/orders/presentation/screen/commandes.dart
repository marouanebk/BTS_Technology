import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/mainpage/presentation/components/search_container.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/components/factor_command_container.dart';
import 'package:bts_technologie/orders/presentation/controller/todo_bloc/command_bloc.dart';
import 'package:bts_technologie/orders/presentation/controller/todo_bloc/command_event.dart';
import 'package:bts_technologie/orders/presentation/controller/todo_bloc/command_state.dart';
import 'package:bts_technologie/orders/presentation/screen/new_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final controller = PageController(initialPage: 0);
  int pageindex = 0;
  List<bool> isDropDownVisibleList = List.generate(15, (index) => false);
  List<String> statusList = [
    'Tous',
    'Téléphone éteint',
    'Ne répond pas',
    'Numero erroné',
    'Annulé',
    'Pas confirmé',
    'Confirmé',
    'Annulé',
    'Préparé',
    'Expédié',
    'Encaissé',
    'Retourné',
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CommandBloc>()..add(GetCommandesEvent()),
      child: Builder(builder: (context) {
        return SafeArea(
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
                  child: searchContainer("Chercher une commande"),
                ),
                const SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: List.generate(statusList.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: dateFilter(index, statusList[index]),
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
                      Map<String, List<Command>> groupedData = {};
                      for (Command command in state.getCommandes) {
                        if (!groupedData.containsKey(command.date)) {
                          groupedData[command.date!] = [];
                        }
                        groupedData[command.date]?.add(command);
                      }
                      return Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
            floatingActionButton: Align(
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
                            builder: (_) => AddOrderPage(),
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
            ),
          ),
        );
      }),
    );
  }

  Widget commandeCard(Command command, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDropDownVisibleList[index] = !isDropDownVisibleList[index];
        });
      },
      child: Column(
        children: [
          Container(
            height: 61,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(5),
                bottom: isDropDownVisibleList[index]
                    ? const Radius.circular(0)
                    : const Radius.circular(5),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  offset: Offset(0, 0),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
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
                  Text(
                    command.status!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isDropDownVisibleList[index])
            FactorCommandContainer(
              command: command,
            ),
        ],
      ),
    );
  }

  Widget dateFilter(number, text) {
    return GestureDetector(
      onTap: () {
        setState(() {
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
