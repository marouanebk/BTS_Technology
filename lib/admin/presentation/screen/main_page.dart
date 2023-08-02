import 'dart:developer';

import 'package:bts_technologie/admin/presentation/components/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Colors.white,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
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
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _commandsStats(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  usersList(),
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
          screenHeader("82", 'assets/images/navbar/commandes_black.svg'),
        ],
      ),
    );
  }

  Widget usersList() {
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
          itemCount: 4,
          itemBuilder: (context, index) {
            return userContainer();
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

  Widget userContainer() {
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
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
              SizedBox(
                height: 5,
              ),
              Text(
                "@mouloud",
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
          const SizedBox(width: 7),
          screenHeader("82", 'assets/images/navbar/commandes_black.svg'),
        ],
      ),
    );
  }

  Widget _commandsStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0 , vertical: 5),
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
                color: Color.fromRGBO(0, 0, 0, 0.15), // Set the shadow color
                offset: Offset(0, 0), // Set the shadow offset
                blurRadius: 12, // Set the shadow blur radius
                spreadRadius: 0, // Set the shadow spread radius
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "342 Commandes",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    "voir les clients",
                    style: TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
      ),
    );
  }

  Widget _progressItem(String label, int progress) {
    return
        //  Table(
        //   columnWidths: { 0: FixedColumnWidth(200.0),// fixed to 100 width
        //         1: FlexColumnWidth(),
        //         2: FlexColumnWidth(),//fixed to 100 width
        //         },
        //   children: [
        //     TableRow(children: [
        //      Text(
        //           label,
        //           textAlign: TextAlign.left,
        //         ),

        //       LinearPercentIndicator(
        //         width: 100.0,
        //         lineHeight: 8.0,
        //         percent: progress / 100,
        //         progressColor: Colors.blue,
        //       ),
        //       Text(
        //         '$progress%',
        //         style: const TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 14,
        //         ),
        //       ),
        //     ]),
        //   ],
        // );

        Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            // Use Expanded for the text to make it start from the left
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(
                    0xFF9F9F9F), // Use var(--text-grey, #9F9F9F) here
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
      ),
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
