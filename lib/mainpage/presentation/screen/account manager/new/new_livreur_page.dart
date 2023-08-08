import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/account_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLivreurAccount extends StatefulWidget {
  const NewLivreurAccount({super.key});

  @override
  State<NewLivreurAccount> createState() => _NewLivreurAccountState();
}

class _NewLivreurAccountState extends State<NewLivreurAccount> {
  TextEditingController livreurNameController = TextEditingController();
  bool _formSubmitted = false;

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    livreurNameController.dispose();
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
                label: "Nom du livreur",
                hintText: "Entrez le nom du livreur",
                errorText: "Vous devez entrer le nom du livreur",
                controller: livreurNameController,
                formSubmitted: _formSubmitted,
              ),
              registerButton(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
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
              if (livreurNameController.text.isEmpty) {
                setState(() {
                  _formSubmitted = true;
                });
                return;
              }
              SharedPreferences prefs = await SharedPreferences.getInstance();
              final token = prefs.getString("token");
              final response = await Dio().post(ApiConstance.createLivreur,
                  data: {"name": livreurNameController.text},
                  options: Options(
                    headers: {
                      "Authorization": "Bearer $token",
                    },
                  ));
              log("response");
              if (response.statusCode == 200) {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AccountManager(), // Replace MainPage with the actual widget class for your MainPage
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
              "Ajouter le livreur",
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
