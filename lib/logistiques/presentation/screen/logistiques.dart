import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_bloc.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_event.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_state.dart';
import 'package:bts_technologie/logistiques/presentation/screen/add_article.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocProvider(
      create: (context) => sl<ArticleBloc>()..add(GetArticlesEvent()),
      child: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    screenHeader("Logistiques",
                        'assets/images/navbar/logis_activated.svg'),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state.getArticlesState == RequestState.loading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    if (state.getArticlesState == RequestState.loaded)
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 7,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.getArticles.length,
                        itemBuilder: (context, index) {
                          return logiItem(state.getArticles[index], index);
                        },
                      ),
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
        },
      ),
    );
  }

  Widget logiItem(article, int index) {
    int totalQuantity =
        article.variants.fold(0, (sum, variant) => sum + variant.quantity);

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
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(5),
                bottom: isDropDownVisibleList[index]
                    ? const Radius.circular(
                        0) // Remove bottom-left and bottom-right radius
                    : const Radius.circular(
                        5), // Keep radius when dropdown is not visible
              ),
              color: Colors.white,
              boxShadow: isDropDownVisibleList[index]
                  ? [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(-5, -5), // Add shadows to top-left
                      ),
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(5, -5), // Add shadows to top-right
                      ),
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(0, -5), // Add shadow to top
                      ),
                    ]
                  : [
                      const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(0, 0), // Add shadows to all sides
                      ),
                    ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${article.name} x $totalQuantity",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 40,
                  height: 52,
                  child: Image.asset(
                      "assets/images/logistiques/sweat_oversize.png"),
                ),
              ],
            ),
          ),
          if (isDropDownVisibleList[index]) articleDropDown(article),
        ],
      ),
    );
  }

  Widget articleDropDown(article) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(5), // Remove top-left and top-right radius
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(-5, 5), // Add shadows to bottom-left
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(5, 5), // Add shadows to bottom-right
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 5), // Add shadow to bottom
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
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
          logExpandedText("Prix d'achat: ", "${article.buyingPrice} DA"),
          const SizedBox(
            height: 15,
          ),
          logExpandedText("Prix de vente en gros: ", "${article.grosPrice} DA"),
          const SizedBox(
            height: 15,
          ),
          logExpandedText("Quantité d'alerte: ", "${article.alertQuantity} DA"),
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
          for (int i = 0; i < article.variants.length; i++)
            logExpandedVariant(article.variants[i], article.alertQuantity),
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

  Widget logExpandedVariant(article, alertQuantity) {
    Color articlesColor = alertQuantity < 5 ? Colors.red : Colors.black;

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
              text: "   ${article.colour}",
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
              text: " | ${article.taille} | ${article.family} ----- ",
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
              text: "${article.quantity} articles",
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
