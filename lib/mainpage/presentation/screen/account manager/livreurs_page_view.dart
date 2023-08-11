import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/account_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LivreursInfoPageView extends StatefulWidget {
  final List<Livreur> livreurs;

  const LivreursInfoPageView({required this.livreurs, super.key});

  @override
  State<LivreursInfoPageView> createState() => _LivreursInfoPageViewState();
}

class _LivreursInfoPageViewState extends State<LivreursInfoPageView> {
  List<bool> isUserDropDownVisibleList = List.generate(15, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.livreurs.length,
              itemBuilder: (context, index) {
                return livreurContainerView(
                    widget.livreurs[index], index, context);
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget livreurContainerView(Livreur livreur, int index, context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isUserDropDownVisibleList[index] = !isUserDropDownVisibleList[index];
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
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Text(
                livreur.livreurName,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            if (isUserDropDownVisibleList[index])
              livreurContainerDropDown(context, livreur.id)
          ],
        ),
      ),
    );
  }

  Widget livreurContainerDropDown(context, id) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                final response =
                    await Dio().delete(ApiConstance.deleteLivreur(id),
                        options: Options(
                          headers: {
                            "Authorization": "Bearer $token",
                          },
                        ));
                if (response.statusCode == 200) {
                  Navigator.of(context).pushReplacementNamed('/accountManager');
                } else {
                  log("failed");
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                "Supprimer la page",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
