import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/mainpage/presentation/components/search_container.dart';
import 'package:bts_technologie/orders/presentation/components/factor_command_container.dart';
import 'package:bts_technologie/orders/presentation/screen/new_order.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final controller = PageController(initialPage: 0);
  int pageindex = 0;
  List<bool> isDropDownVisibleList = List.generate(15, (index) => false);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              screenHeader(
                  "Commandes", 'assets/images/navbar/commandes_activated.svg'),
              const SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 20.0),
                child: searchContainer("Chercher une commande"),
              ),
                 const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      dateFilter(0, "Tous"),
                      const SizedBox(
                        width: 10,
                      ),
                      dateFilter(1, "Telephone eteint"),
                      const SizedBox(
                        width: 10,
                      ),
                      dateFilter(2, "Pas confirme"),
                      const SizedBox(
                        width: 10,
                      ),
                      dateFilter(3, "Annule"),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Aujourd'hui"),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 14,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return commandeCard(18796, "Numéro érroné", index);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
  }

  Widget commandeCard(int number, String status, int index) {
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Com N° $number",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    status,
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
          if (isDropDownVisibleList[index]) const FactorCommandContainer(),
        ],
      ),
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
