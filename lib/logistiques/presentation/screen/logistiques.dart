import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/logistics_base_screen.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_bloc.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_event.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_state.dart';
import 'package:bts_technologie/logistiques/presentation/screen/add_article.dart';
import 'package:bts_technologie/logistiques/presentation/screen/edit_article.dart';
import 'package:bts_technologie/mainpage/presentation/components/screen_header.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:bts_technologie/orders/presentation/screen/commandes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logistiques extends StatefulWidget {
  final String role;
  const Logistiques({required this.role, super.key});

  @override
  State<Logistiques> createState() => _LogistiquesState();
}

class _LogistiquesState extends State<Logistiques> {
  late List<bool> isDropDownVisibleList;
  bool isListInitialized = false;

  @override
  void initState() {
    super.initState();
    isDropDownVisibleList = List.generate(
      15, // You can replace this with any initial length you want
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    //   statusBarColor: Colors.white,
    // ));

    return BlocProvider(
      create: (context) => sl<ArticleBloc>()..add(GetArticlesEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<ArticleBloc>().add(GetArticlesEvent());
              },
              child: SingleChildScrollView(
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
                      BlocBuilder<ArticleBloc, ArticleState>(
                          builder: (context, state) {
                        if (state.getArticlesState == RequestState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          );
                        }
                        if (state.getArticlesState == RequestState.loaded) {
                          if (isListInitialized == false) {
                            isDropDownVisibleList = List.generate(
                              state.getArticles.length,
                              (index) => false,
                            );
                            isListInitialized = true;
                          }
                          return ListView.separated(
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 7,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.getArticles.length,
                            itemBuilder: (context, index) {
                              return logiItem(
                                  state.getArticles[index], index, context);
                            },
                          );
                        }
                        return Container();
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
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
                            builder: (_) => NewArticle(
                              role: widget.role,
                            ),
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

  Widget logiItem(article, int index, context) {
    int totalQuantity =
        article.variants.fold(0, (sum, variant) => sum + variant.quantity);

    bool hasPhoto = article.photoUrl != null && article.photoUrl.isNotEmpty;

    return GestureDetector(
      onTap: () {
        setState(() {
          isDropDownVisibleList[index] = !isDropDownVisibleList[index];
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 12,
              spreadRadius: 0,
              offset: Offset(0, 0), // Add shadows to all sides
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.only(
                  left: 15, right: 20, top: 8, bottom: 10),
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
                    child: hasPhoto
                        ? Image.network(article.photoUrl)
                        // ? FutureBuilder<Uint8List>(
                        //     future: _fetchImage(article.photoUrl),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState ==
                        //           ConnectionState.waiting) {
                        //         return CircularProgressIndicator();
                        //       } else if (snapshot.hasError) {
                        //         return Text('Error loading image');
                        //       } else {
                        //         return Image.memory(snapshot.data!);
                        //       }
                        //     },
                        //   )
                        : Image.asset(
                            "assets/images/logistiques/sweat_oversize.png"), // Fallback asset image
                  ),
                ],
              ),
            ),
            if (isDropDownVisibleList[index]) articleDropDown(article, context),
          ],
        ),
      ),
    );
  }

  Widget articleDropDown(article, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
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
          modifyButton(context, article),
          const SizedBox(
            height: 5,
          ),
          deleteButton(context, article.id),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget deleteButton(context, id) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 50, // Set the height to 50
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final token = prefs.getString("token");
            final response = await Dio().delete(ApiConstance.deleteArticle(id),
                options: Options(
                  headers: {
                    "Authorization": "Bearer $token",
                  },
                ));
            if (response.statusCode == 200) {
              // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) {
              //       return Logistiques(
              //         role: widget.role,
              //       );
              //     },
              //   ),
              //   (_) => false,
              // );

              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     if (widget.role == "logistics") {
              //       return const LogistiquesBaseScreen(initialIndex: 2);
              //     } else {
              //       return const PageAdministratorBaseScreen(initialIndex: 3);
              //     }
              //   }),
              // );

              // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) {
              //     if (widget.role == "logistics") {
              //       return const LogistiquesBaseScreen(initialIndex: 2);
              //     } else {
              //       return const PageAdministratorBaseScreen(initialIndex: 3);
              //     }
              //   }),
              //   (route) => false,
              // );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Logistiques(
                      role: widget.role,
                    );
                  },
                ),
              );

              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     if (widget.role == "logistics") {
              //       return const LogistiquesBaseScreen(initialIndex: 2);
              //     } else {
              //       return const PageAdministratorBaseScreen(initialIndex: 3);
              //     }
              //   }),
              //   (route) => false,
              // );
              // BlocProvider.of<ArticleBloc>(context).add(GetArticlesEvent());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.transparent,
                  content: CustomStyledSnackBar(
                      message: "Article Deleted", success: true),
                ),
              );

              // Navigator.of(context).pushReplacementNamed('/accountManager');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.transparent,
                  content:
                      CustomStyledSnackBar(message: "Error", success: false),
                ),
              );
            }
          },
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

  Widget modifyButton(context, article) {
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
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (_) =>
                    EditArticle(role: widget.role, article: article),
              ),
            );
          },
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
    Color containerColor;
    try {
      containerColor = Color(int.parse(article.codeColour, radix: 16));
    } catch (e) {
      containerColor = Colors.transparent;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: containerColor,
                  border: Border.all(
                    color: Colors.black, // You can change the border color here
                    width: 1, // You can adjust the border width here
                  ),
                ),
              ),
              const SizedBox(width: 4), // Add some spacing
              AutoSizeText(
                article.colour,
                style: const TextStyle(
                  color:
                      Color(0xFF9F9F9F), // Use var(--text-grey, #9F9F9F) here
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
                maxLines: 1, // Adjust this based on your design
              ),
              const SizedBox(width: 4), // Add some spacing
              const Text(
                "|",
                style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 4), // Add some spacing
              AutoSizeText(
                "${article.taille} | ${article.family} ----- ",
                style: const TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
                maxLines: 1, // Adjust this based on your design
              ),
              AutoSizeText(
                "${article.quantity} articles",
                style: TextStyle(
                  color: articlesColor,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
                maxLines: 1, // Adjust this based on your design
              ),
            ],
          ),
        ],
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

  Future<Uint8List> _fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
