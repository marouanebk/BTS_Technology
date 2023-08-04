import 'package:bts_technologie/logistiques/presentation/screen/add_article.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:flutter/material.dart';

class Logistiques extends StatefulWidget {
  const Logistiques({super.key});

  @override
  State<Logistiques> createState() => _LogistiquesState();
}

class _LogistiquesState extends State<Logistiques> {
  List<bool> isDropDownVisibleList = List.generate(15, (index) => false);

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
              screenHeader(
                  "Logistiques", 'assets/images/navbar/logis_activated.svg'),
              const SizedBox(
                height: 30,
              ),
              logiItem("Sweat oversize", 128,
                  "assets/images/logistiques/sweat_oversize.png", 0),
              const SizedBox(
                height: 7,
              ),
              logiItem("Bob", 21, "assets/images/logistiques/bob.jpg", 1),
              const SizedBox(
                height: 7,
              ),
              logiItem(
                  "Tshirt", 229, "assets/images/logistiques/tshirt.jpg", 2),
              const SizedBox(
                height: 7,
              ),
              logiItem(
                  "jogging", 76, "assets/images/logistiques/jogging.jpg", 3),
              const SizedBox(
                height: 7,
              ),
              logiItem(
                  "Casquette", 48, "assets/images/logistiques/casquet.jpg", 4),
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

  Widget logiItem(String product, int quantity, String link, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDropDownVisibleList[index] = !isDropDownVisibleList[index];
        });
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            padding:
                const EdgeInsets.only(left: 15, right: 20, top: 8, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: isDropDownVisibleList[index]
                  ? [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                      ),
                    ]
                  : [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0),
                        blurRadius: 0,
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
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 40,
                  height: 52,
                  child: Image.asset(link),
                ),
              ],
            ),
          ),
          if (isDropDownVisibleList[index]) articleDropDown(),
        ],
      ),
    );
  }

  Widget articleDropDown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(-5, 0), // Add left shadow
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(5, 0), // Add right shadow
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 5), // Add bottom shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity, // To take full width
            child: Divider(
              height: 1, // The thickness of the line (1px)
              thickness: 1, // The thickness of the line (1px)
              color: Color(
                  0xFFECECEC), // The color of the line (var(--highlight-grey, #ECECEC))
            ),
          ),
          logExpandedText("Prix d'achat: ", "800 DA"),
          const SizedBox(
            height: 15,
          ),
          logExpandedText("Prix de vente en gros: ", "800 DA"),
          const SizedBox(
            height: 15,
          ),
          logExpandedText("Quantité d'alerte: ", "800 DA"),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            width: double.infinity, // To take full width
            child: Divider(
              height: 1, // The thickness of the line (1px)
              thickness: 1, // The thickness of the line (1px)
              color: Color(
                  0xFFECECEC), // The color of the line (var(--highlight-grey, #ECECEC))
            ),
          ),
          logExpandedVariant("Noir", "S","regular", 12),
          logExpandedVariant("Noir", "S","regular", 12),
          logExpandedVariant("Noir", "S","regular", 12),
          logExpandedVariant("Noir", "S","regular", 12),
          logExpandedVariant("Noir", "S","regular", 12),
          logExpandedVariant("Noir", "S","regular", 3),
          const SizedBox(
            height: 15,
          ),
          modifyButton(),
          const SizedBox(
            height: 5,
          ),
          deleteButton(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget deleteButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
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
            "Supprimer l'article",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget modifyButton() {
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
          child: const Text(
            "Modifier L'article",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget logExpandedVariant(String color, String size,String type, int numberOfArticles) {
    Color articlesColor = numberOfArticles < 5 ? Colors.red : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
                child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            )),
            TextSpan(
              text: "   $color",
              style: const TextStyle(
                color: Color(0xFF9F9F9F), // Use var(--text-grey, #9F9F9F) here
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
            TextSpan(
              text: " | $size | $type ----- ",
              style: const TextStyle(
                color: Color(0xFF9F9F9F),
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
            TextSpan(
              text: "$numberOfArticles articles",
              style: TextStyle(
                color: articlesColor,
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget logExpandedText(String text, String price) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Color(0xFF9F9F9F), // Use var(--text-grey, #9F9F9F) here
              fontFamily: 'Inter',
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
          TextSpan(
            text: price,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontFamily: 'Inter',
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
