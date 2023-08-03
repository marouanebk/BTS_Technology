 import 'package:flutter/material.dart';

Widget factorContainer() {
    return Container(
      width: double.infinity,
      height: 364,
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
            const Text(
              "Com N° 18796",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 24,
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
            const Text(
              "2 x Tshirt",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Personnalisé détail | rouge | XL",
              style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "3 x Sweat oversize",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Personnalisé détail | rouge | XL",
              style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
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
            )
          ],
        ),
      ),
    );
  }