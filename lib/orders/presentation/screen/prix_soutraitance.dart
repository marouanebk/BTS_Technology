import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/finances_base_screen.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrixSoutraitancePage extends StatefulWidget {
  final String id;
  final String role;
  const PrixSoutraitancePage({required this.id, required this.role, super.key});

  @override
  State<PrixSoutraitancePage> createState() => _PrixSoutraitancePageState();
}

class _PrixSoutraitancePageState extends State<PrixSoutraitancePage> {
  TextEditingController moneyController = TextEditingController();
  bool _formSubmitted = false;

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "Ajouter le prix soutraitance"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              buildInputField(
                label: "Prix Soutraitance ",
                hintText: "Entrez le prix Soutraitance ",
                errorText: "Vous devez entrer le prix soutraitance",
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
              if (moneyController.text.isEmpty) {
                setState(() {
                  _formSubmitted = true;
                });
                return;
              }
              num money = num.parse(moneyController.text);
              if (money > 0) money = -money;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              final token = prefs.getString("token");
              final response =
                  await Dio().post(ApiConstance.soutraitanceCommand(widget.id),
                      data: {"amount": num.parse(moneyController.text)},
                      options: Options(
                        headers: {
                          "Authorization": "Bearer $token",
                        },
                      ));
              if (response.statusCode == 200) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    if (widget.role == "financier") {
                      return const FinancesBaseScreen(initialIndex: 0);
                    } else {
                      return const PageAdministratorBaseScreen(initialIndex: 1);
                    }
                  }),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.transparent,
                    content: CustomStyledSnackBar(
                        message: "Prix sous traitant ajouté", success: true),
                  ),
                );
              } else {
                SnackBar(
                    content: CustomStyledSnackBar(
                        message: response.data['err'], success: false));
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
