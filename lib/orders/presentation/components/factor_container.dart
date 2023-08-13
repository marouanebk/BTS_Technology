import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/components/image_detail_page.dart';
import 'package:flutter/material.dart';

Widget factorContainer(context, Command command) {
  return Container(
    width: double.infinity,
    // height: 364,
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
          Text(
            "Com N° ${command.comNumber}",
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
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
          const SizedBox(
            height: 8,
          ),
          for (var item in command.articleList) productDetail(item!),
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
          const SizedBox(
            height: 5,
          ),
          clientInfo(command),
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
        ],
      ),
    ),
  );
}

Widget clientInfo(Command command) {
  int totalPrice = command.articleList.fold(0, (sum, article) {
    return sum + (article!.quantity * article.unityPrice.toInt());
  });

  String totalPriceMessage = command.sommePaid == 0
      ? totalPrice.toString()
      : "$totalPrice - ${command.sommePaid.toString()} ";

  String st;
  if (command.prixSoutraitant == null) {
    st = "non définie";
  } else {
    st = command.prixSoutraitant.toString();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          children: [
            const WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.location_on,
                  size: 16,
                ),
              ),
            ),
            TextSpan(
              text: command.adresse,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF9F9F9F),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          children: [
            const WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.phone,
                  size: 16,
                ),
              ),
            ),
            TextSpan(
              text: command.phoneNumber.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF9F9F9F),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          children: [
            const WidgetSpan(
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
              text: totalPriceMessage,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF9F9F9F),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.event_note,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: command.noteClient,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9F9F9F),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      // Prix Soutraitant
      RichText(
        text: TextSpan(
          children: [
            const WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  // Icons.event_note,
                  Icons.numbers,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
            TextSpan(
              text: st,
              style: const TextStyle(
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

Widget productDetail(CommandArticle command) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${command.quantity} x ${command.articleName}",
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "${command.commandType} | ${command.colour} | ${command.taille} | ${command.family} ",
        style: const TextStyle(
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
