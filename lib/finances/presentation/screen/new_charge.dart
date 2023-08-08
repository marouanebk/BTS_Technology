import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/finances/presentation/screen/finances.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/account_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewFinanceCharge extends StatefulWidget {
  const NewFinanceCharge({super.key});

  @override
  State<NewFinanceCharge> createState() => _NewFinanceChargeState();
}

class _NewFinanceChargeState extends State<NewFinanceCharge> {
  TextEditingController labelController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  bool _formSubmitted = false;

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    labelController.dispose();
    moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "ajouter des charges"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              buildInputField(
                label: "Raison",
                hintText: "Entrez la raison de ses cahrges",
                errorText: "Vous devez citer la raison des charges",
                controller: labelController,
                formSubmitted: _formSubmitted,
              ),
              buildInputField(
                label: "Somme",
                hintText: "Entrez la somme",
                errorText: "Vous devez donner la somme",
                controller: moneyController,
                formSubmitted: _formSubmitted,
                isNumeric: true,
                isMoney: true,
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
              if (labelController.text.isEmpty ||
                  moneyController.text.isEmpty) {
                setState(() {
                  _formSubmitted = true;
                });
                return;
              }
              num money = num.parse(moneyController.text);
              if (money > 0) money = -money;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              final token = prefs.getString("token");
              final response = await Dio().post(
                  ApiConstance.createFinanceChargeApi,
                  data: {
                    "label": labelController.text,
                    "money": num.parse(moneyController.text)
                  },
                  options: Options(
                    headers: {
                      "Authorization": "Bearer $token",
                    },
                  ));
              if (response.statusCode == 200) {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const FinancesPage(),
                //   ),
                //   (Route<dynamic> route) =>
                //       false, // This prevents user from going back
                // );
                

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FinancesPage(),
                    maintainState:
                        false, // This prevents the previous page from being maintained
                  ),
                );
              } else {
                log(response.data['error']);
                log("failed");
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Text(
              "Enregistrer",
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
