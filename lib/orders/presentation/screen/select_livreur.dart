import 'dart:developer';

import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/finances_base_screen.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLivreur extends StatefulWidget {
  final String id;
  final String role;
  const SelectLivreur({required this.id, required this.role, super.key});

  @override
  State<SelectLivreur> createState() => _SelectLivreurState();
}

class _SelectLivreurState extends State<SelectLivreur> {
  bool _formSubmitted = false;
  int? _groupValue ;
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AccountBloc>()..add(GetLivreursEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar:
              const CustomAppBar(titleText: "Vous devez selection un livreur"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      if (state.getLivreursState == RequestState.loading) {
                        return const CircularProgressIndicator(
                          color: Colors.black,
                        );
                      } else if (state.getLivreursState ==
                          RequestState.loaded) {
                        return Column(
                          children: [
                            for (int i = 0; i < state.getLivreurs.length; i++)
                              RadioListTile<int>(
                                activeColor: Colors.black,
                                title: Text(state.getLivreurs[i].livreurName),
                                value: i,
                                groupValue: _groupValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    _groupValue = value;
                                  });
                                },
                              ),
                            registerButton(state, context),
                          ],
                        );
                      } else if (state.getLivreursState == RequestState.error) {
                        return Text(state.getLivreursmessage);
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget registerButton(state, context) {
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
              int? selectedValue = _groupValue;
              if (selectedValue != null) {
                String livreurId = state.getLivreurs[selectedValue].id;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final token = prefs.getString("token");
                final response = await Dio().patch(
                  ApiConstance.updateCommandStatus(
                      widget.id), // Replace with your API URL
                  data: {'status': 'Expidié', 'livreur': livreurId},
                  options: Options(
                    headers: {'Authorization': 'Bearer $token'},
                  ),
                );
                if (response.statusCode == 200) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      if (widget.role == "financier") {
                        return const FinancesBaseScreen(initialIndex: 0);
                      } else {
                        return const PageAdministratorBaseScreen(
                            initialIndex: 1);
                      }
                    }),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.transparent,
                      content: CustomStyledSnackBar(
                          message: "Command Modifier", success: true),
                    ),
                  );
                } else {
                  SnackBar(
                      content: CustomStyledSnackBar(
                          message: response.data['err'], success: false));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.transparent,
                    content: CustomStyledSnackBar(
                        message: "Selectioner un livreur", success: false),
                  ),
                );
              }
              // if (moneyController.text.isEmpty) {
              //   setState(() {
              //     _formSubmitted = true;
              //   });
              //   return;
              // }
              // num money = num.parse(moneyController.text);
              // if (money > 0) money = -money;

              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // final token = prefs.getString("token");
              // final response = await Dio().patch(
              //   ApiConstance.updateCommandStatus(
              //       widget.id!), // Replace with your API URL
              //   data: {'status': 'Expidié'},
              //   options: Options(
              //     headers: {'Authorization': 'Bearer $token'},
              //   ),
              // );
              // if (response.statusCode == 200) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (context) {
              //       if (widget.role == "financier") {
              //         return const FinancesBaseScreen(initialIndex: 0);
              //       } else {
              //         return const PageAdministratorBaseScreen(initialIndex: 1);
              //       }
              //     }),
              //   );

              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       backgroundColor: Colors.transparent,
              //       content: CustomStyledSnackBar(
              //           message: "Prix sous traitant ajouté", success: true),
              //     ),
              //   );
              // } else {
              //   SnackBar(
              //       content: CustomStyledSnackBar(
              //           message: response.data['err'], success: false));
              // }
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
