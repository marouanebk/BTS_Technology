import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(initialPage: 0);
  int pageindex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topContainer(),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  dateFilter(0, "Avr 23"),
                  const SizedBox(
                    width: 10,
                  ),
                  dateFilter(1, "Mai 23"),
                  const SizedBox(
                    width: 10,
                  ),
                  dateFilter(2, "Jui 23"),
                  const SizedBox(
                    width: 10,
                  ),
                  dateFilter(3, "Jui 23"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  log("page ${index + 1} ");
                  pageindex = index;
                  setState(() {
                    index;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _dateStats(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateStats() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 323,
        width: 309,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 0), // You can adjust the shadow's position here
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
            const Text(
              "342 Commandes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
            _progressItem("Téléphone éteint", 15),
            _progressItem("Ne répond pas", 15),
            _progressItem("Numero erroné", 15),
            _progressItem("Annulé", 15),
            _progressItem("Pas confirmé", 15),
            _progressItem("Confirmé", 15),
            _progressItem("Préparé", 15),
            _progressItem("Expidié", 15),
            _progressItem("Encaissé", 15),
            _progressItem("Retourné", 15),
          ],
        ),
      ),
    );
  }

  Widget _progressItem(String label, int progress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          // Use Expanded for the text to make it start from the left
          child: Text(
            label,
            textAlign: TextAlign.right,
          ),
        ),
        LinearPercentIndicator(
          width: 100.0,
          lineHeight: 8.0,
          percent: progress / 100,
          progressColor: Colors.blue,
        ),
        const SizedBox(width: 8), // Add some space between indicator and text
        Text(
          '$progress%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _topContainer() {
    return Container(
      height: 201,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF072072),
            Color(0xFF53B7FF),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.help_outline,
                    size: 33,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.help_outline,
                    size: 33,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Text(
            "bienvenue",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Text(
            "Aziz Berrazouane",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 20,
            width: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.white,
            ),
          )
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
