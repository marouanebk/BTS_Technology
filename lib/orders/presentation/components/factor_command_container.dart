import 'dart:developer';

import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/components/image_detail_page.dart';
import 'package:flutter/material.dart';

class FactorCommandContainer extends StatefulWidget {
  final Command command;
  const FactorCommandContainer({required this.command, super.key});

  @override
  State<FactorCommandContainer> createState() => _FactorCommandContainerState();
}

class _FactorCommandContainerState extends State<FactorCommandContainer> {
  String? type;
  @override
  void initState() {
    super.initState();
    type = widget.command.status;
    // type = "Pas confirmé";
  }

  List<Map<String, String>> statusListAdmin = [
    {'label': 'Téléphone', "value": "Téléphone"},
    {'label': 'Numero erroné', "value": "Numero erroné"},
    {'label': 'Annulé', "value": "Annulé"},
    {'label': 'Pas confirmé', "value": "Pas confirmé"},
    {'label': 'Préparé', "value": "Préparé"},
    {'label': 'Expidié', "value": "Expidié"},
    {'label': 'Encaissé', "value": "Encaissé"},
    {'label': 'Retourné', "value": "Retourné"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 0),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 24, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFECECEC),
              ),
            ),
            for (var item in widget.command.articleList )
            
            productDetail("Sweat oversize", 3),
            productDetail("Tshirt", 3),
            const SizedBox(
              width: double.infinity,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFECECEC),
              ),
            ),
            clientInfo(),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 8.0, // Adjust spacing between images
              runSpacing: 8.0, // Adjust spacing between lines
              children: [
                ...List.generate(
                  5,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        _createRoute("assets/images/tshirt_${index + 1}.png"),
                      );
                    },
                    child: Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color(0xFFECECEC),
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/tshirt_2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            containerButton("Modifier la commande"),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(onPressed: () {
            //   log(type.toString());
            // }, child: Text("click me")),
            containerButton("Générer une facture"),
            const SizedBox(
              height: 10,
            ),
            confirmationContainer(
              value: type,
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Saisie par @walid",
                style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Center(
              child: Text(
                "Livré par Yalidine",
                style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.location_on,
                    size: 16,
                  ),
                ),
              ),
              TextSpan(
                text: 'Kalitous, Alger',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9F9F9F),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.phone,
                    size: 16,
                  ),
                ),
              ),
              TextSpan(
                text: '0783 98 78 67',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9F9F9F),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
              TextSpan(
                text: '3 x 1200DA',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9F9F9F),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget productDetail(String title, int quantity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$quantity x $title",
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Personnalisé détail | rouge | XL | regular",
          style: TextStyle(
              color: Color(0xFF9F9F9F),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget confirmationContainer(
      {required String? value, required void Function(String?) onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 50, // Set the height to 50
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(
                0xFF111111), // Replace with your desired border color
            width: 1,
          ),
        ),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,

              // hint: Text("hintText"),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              // style: const TextStyle(
              //     fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
              dropdownColor: Colors.black,
              iconEnabledColor: Colors.white,
              iconSize: 30,
              icon: const Icon(Icons.arrow_drop_down),
              items: statusListAdmin.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['value'],
                  child: Center(child: Text(item['label']!)),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget containerButton(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 50, // Set the height to 50
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(
                0xFF111111), // Replace with your desired border color
            width: 1,
          ),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute(String imagePath) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ImageDetailPage(imagePath: imagePath);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
