import 'dart:developer';

import 'package:bts_technologie/authentication/data/models/user_model.dart';
import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_event.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_state.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/logistiques/presentation/components/select_field_input.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/presentation/components/check_box.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/account_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserPage extends StatefulWidget {
  final User user;
  final List<FacePage> pages;
  const EditUserPage({required this.user, required this.pages, super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _formSubmitted = false;
  String? type;

  List<int> _selectedPages = [];
  List<int> _selectedCommandeTypes = [];
  String error = "";

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with existing user data if provided
    fullnameController.text = widget.user.fullname!;
    usernameController.text = widget.user.username;

    // Optionally, you can set initial values for other fields if needed
    type = widget.user.role;

    // _selectedPagesTemp = widget.user.pages ?? [];

    // // Initialize the selected commande types based on the user's existing selections
    // _selectedCommandeTypesTemp = widget.user.commandeTypes ?? [];
    log(widget.user.pages.toString());
    log(widget.user.commandeTypes.toString());

    for (int i = 0; i < widget.pages.length; i++) {
      if (widget.user.pages!.contains(widget.pages[i].id)) {
        // Add the index of the page to the selected pages list
        _selectedPages.add(i);
      }
    }
    log(_selectedPages.toString());

    for (int i = 0; i < commandeTypes.length; i++) {
      if (widget.user.commandeTypes!.contains(commandeTypes[i])) {
        // Add the index of the command type to the selected command types list
        _selectedCommandeTypes.add(i);
      }
    }
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    fullnameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  List<String> commandeTypes = [
    'Vierge détail',
    'Personnalisé détail',
    'Gros personnalisé',
    'Gros détail',
  ];

  List<Map<String, String>> rolesList = [
    {"label": "Admin de lapplication", "value": "admin"},
    {"label": "Admin d'une page", "value": "pageAdmin"},
    {"label": "Responsable logistiques", "value": "financier"},
    {"label": "Financier", "value": "logistics"},
  ];

  void _checkFormValidation(context) {
    bool hasEmptyFields = false;

    // Check if any of the input fields are empty
    if (fullnameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        type == null) {
      hasEmptyFields = true;
    }

    if (type == 'pageAdmin' && _selectedPages.isEmpty) {
      hasEmptyFields = true;
    }

    // Check if user type is pageAdmin and at least one command type is selected
    if (type == 'pageAdmin' && _selectedCommandeTypes.isEmpty) {
      hasEmptyFields = true;
    }

    if (hasEmptyFields) {
      setState(() {
        _formSubmitted = true;
      });
      return;
    }

    // If all fields are filled, proceed with the submission
    setState(() {
      _formSubmitted = true;
    });
    _submitForm(context);
  }

  void _submitForm(context) async {
    UserModel userModel;
    String password = passwordController.text.isEmpty
        ? widget.user.password!
        : passwordController.text;
    if (type == "pageAdmin") {
      List<String> selectedPages = _selectedPages.map((index) {
        return widget.pages[index].id!;
      }).toList();

      // Retrieve selected commande types
      List<String> selectedCommandeTypes = _selectedCommandeTypes.map((index) {
        return commandeTypes[index];
      }).toList();
      userModel = UserModel(
        username: usernameController.text,
        password: password,
        fullname: fullnameController.text,
        role: type,
        pages: selectedPages,
        commandeTypes: commandeTypes,
      );
    } else {
      userModel = UserModel(
        username: usernameController.text,
        password: password,
        fullname: fullnameController.text,
        role: type,
        pages: const [],
        commandeTypes: const [],
      );
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().patch(ApiConstance.editUser(widget.user.id!),
        data: userModel.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    log("response");
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/accountManager');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          content:
              CustomStyledSnackBar(message: "Compte Modifier", success: true),
        ),
      );
    } else {
      log("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const CustomAppBar(titleText: "Modifier le compte"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  buildSelectField(
                    label: "Type ",
                    hintText: "- Sélectionnez une type de compte -",
                    errorText: "Vous devez entrer une type",
                    value: type,
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                    items: rolesList,
                    formSubmitted: _formSubmitted,
                  ),
                  buildInputField(
                    label: "Nom complet",
                    hintText: "Entrez le nom complet",
                    errorText: "Vous devez entrer le nom complet",
                    controller: fullnameController,
                    formSubmitted: _formSubmitted,
                  ),
                  buildInputField(
                    label: "Nom d'utilisateur",
                    hintText: "Entrez le pseudo utilisé pour s'inscrire",
                    errorText: "Vous devez entrer le Nom d'utilisateur",
                    controller: usernameController,
                    formSubmitted: _formSubmitted,
                  ),
                  buildInputField(
                    label: "Mot de passe",
                    hintText: "Entrez le mot de passe du compte",
                    errorText: "",
                    controller: passwordController,
                    formSubmitted: _formSubmitted,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (type == 'pageAdmin')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Pages à gérer",
                          style: TextStyle(
                            color: // Black color if activated
                                Color(
                                    0xFF9F9F9F), // Grey color if not activated
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.pages.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: RoundedCheckbox(
                                value: _selectedPages.contains(index),
                                label: widget.pages[index].pageName,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedPages.add(index);
                                    } else {
                                      _selectedPages.remove(index);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Pages à gérer",
                          style: TextStyle(
                            color: // Black color if activated
                                Color(
                                    0xFF9F9F9F), // Grey color if not activated
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: commandeTypes.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: RoundedCheckbox(
                                value: _selectedCommandeTypes.contains(index),
                                label: commandeTypes[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedCommandeTypes.add(index);
                                    } else {
                                      _selectedCommandeTypes.remove(index);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  BlocBuilder<UserBloc, UserBlocState>(
                    builder: (context, state) {
                      final bool isLoading = state is LoadingUserBlocState;
                      return registerButton(isLoading, context);
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

  Widget registerButton(isLoading, context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50, // Set the height to 50
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    _checkFormValidation(context);
                  },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    "Enregister le compte",
                    style: TextStyle(
                      fontSize: 18,
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
