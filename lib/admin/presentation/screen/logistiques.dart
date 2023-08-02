import 'package:bts_technologie/admin/presentation/screen/new/add_article.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logistiques extends StatefulWidget {
  const Logistiques({super.key});

  @override
  State<Logistiques> createState() => _LogistiquesState();
}

class _LogistiquesState extends State<Logistiques> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    //   statusBarColor: Colors.white,
    // ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SvgPicture.asset(
                          'assets/images/navbar/logis_black.svg', // Replace with the actual path to your SVG image
                          width: 21,
                          height: 21,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: 'Logistiques',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              logiItem("Sweat oversize", 128,
                  "assets/images/logistiques/sweat_oversize.png"),
              const SizedBox(
                height: 7,
              ),
              logiItem("Bob", 21, "assets/images/logistiques/bob.jpg"),
              const SizedBox(
                height: 7,
              ),
              logiItem("Tshirt", 229, "assets/images/logistiques/tshirt.jpg"),
              const SizedBox(
                height: 7,
              ),
              logiItem("jogging", 76, "assets/images/logistiques/jogging.jpg"),
              const SizedBox(
                height: 7,
              ),
              logiItem(
                  "Casquette", 48, "assets/images/logistiques/casquet.jpg"),
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
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (_) => NewArticle(),
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
    );
  }

  Widget logiItem(String product, int quantity, String link) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.only(left: 15, right: 20, top: 8, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$product x $quantity",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            width: 40,
            height: 52,
            child: Image.asset(link),
          ),
        ],
      ),
    );
  }
}
