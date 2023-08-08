import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/account_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPageAccount extends StatefulWidget {
  const NewPageAccount({super.key});

  @override
  State<NewPageAccount> createState() => _NewPageAccountState();
}

class _NewPageAccountState extends State<NewPageAccount> {
  TextEditingController pageNameController = TextEditingController();
  bool _formSubmitted = false;

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    pageNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "ajouter une page"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              buildInputField(
                label: "Nom de la page",
                hintText: "Entrez le nom complet",
                errorText: "Vous devez entrer le nom",
                controller: pageNameController,
                formSubmitted: _formSubmitted,
              ),
              registerButton(context),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerButton(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50, // Set the height to 50
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            onPressed: () async {
              if (pageNameController.text.isEmpty) {
                setState(() {
                  _formSubmitted = true;
                });
                return;
              }
              SharedPreferences prefs = await SharedPreferences.getInstance();
              final token = prefs.getString("token");
              final response = await Dio().post(ApiConstance.createPage,
                  data: {"name": pageNameController.text},
                  options: Options(
                    headers: {
                      "Authorization": "Bearer $token",
                    },
                  ));
              log("response");
              if (response.statusCode == 200) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                      const   AccountManager(), // Replace MainPage with the actual widget class for your MainPage
                  ),
                );
              } else {
                log("failed");
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Text(
              "Ajouter la page",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
