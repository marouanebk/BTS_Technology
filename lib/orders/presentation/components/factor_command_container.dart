import 'package:flutter/material.dart';

class FactorCommandContainer extends StatelessWidget {
  const FactorCommandContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            Row(
              children: [
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(
                          0xFFECECEC), // You can also use Colors.grey[200]
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/tshirt_2.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(
                          0xFFECECEC), // You can also use Colors.grey[200]
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/tshirt_1.png",
                    fit: BoxFit.cover,
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
            containerButton("Générer une facture"),
            const SizedBox(
              height: 10,
            ),
            confirmationContainer(),
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

  Widget confirmationContainer() {
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
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: const Text(
            "Confirme",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
