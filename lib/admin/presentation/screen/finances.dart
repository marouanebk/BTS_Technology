import 'dart:math';

import 'package:bts_technologie/admin/presentation/components/screen_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({super.key});

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Center(
                    child: screenHeader(
                        "Finances", 'assets/images/navbar/finances_black.svg')),
                const SizedBox(
                  height: 30,
                ),
                _topContainer(),
                const SizedBox(
                  height: 30,
                ),
                _cashflow(),
                const SizedBox(
                  height: 30,
                ),
                revenueList(),
              ],
            ),
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
                    // Navigator.of(context, rootNavigator: true).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => NewArticle(),
                    //   ),
                    // );
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

  Widget revenueList() {
    final random = Random();
    final isRed = random.nextBool();

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
          itemCount: 8,
          itemBuilder: (context, index) {
            final isRed = random.nextBool();

            return revenueItem(isRed);
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget revenueItem(bool isRed) {
    final backgroundColor =
        isRed ? Colors.red : Colors.green;

    return Container(
      width: double.infinity,
      height: 70,
      // padding: const EdgeInsets.only(right: 15, left: 15, top: 18, ),
      padding: const EdgeInsets.only(right: 5),
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
          const Padding(
            padding: EdgeInsets.only(
              right: 15,
              left: 15,
              top: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "- 8,000 DA",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Inter",
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Frais des livraisons",
                  style: TextStyle(
                    color: Color(0xFF9F9F9F),
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isRed ? const Color.fromRGBO(255, 68, 68, 0.1) :const Color.fromRGBO(7, 176, 24, 0.1) ,
            ),
            child:  Center(
              child: Icon(
                Icons.keyboard_arrow_up,
                size: 35,
                // color: Colors.red,
                color: backgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cashflow() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Analytiques du cashflow",
                  style: TextStyle(
                    color: Color(0xFF9F9F9F),
                    fontFamily: "Inter",
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "325,500 DA",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            Text(
              "Par mois",
              style: TextStyle(
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
        Container(),
      ],
    );
  }

  Widget _topContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Solde chez livreurs",
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
        const SizedBox(
          height: 10,
        ),
        Container(
          // height: 80,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.15),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "48,000 DA",
                style: TextStyle(
                  color:
                      Color(0xFF111111), // Replace with your desired text color
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
              _livreurComp(),
              const SizedBox(
                height: 10,
              ),
              _livreurComp(),
              const SizedBox(
                height: 10,
              ),
              _livreurComp(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _livreurComp() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Livreur 1",
          style: TextStyle(
            color: Color(0xFF111111), // Replace with your desired text color
            fontFamily: "Inter",
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            height: 1.0,
          ),
          textAlign: TextAlign.right,
        ),
        Text(
          "5,000",
          style: TextStyle(
            color: Color(0xFF9F9F9F), // Replace with your desired text color
            fontFamily: "Inter",
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
