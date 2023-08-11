import 'package:bts_technologie/authentication/data/models/user_model.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_bloc.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_event.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_state.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/logistiques/presentation/components/select_field_input.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/presentation/components/check_box.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/account_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewUserPage extends StatefulWidget {
  final List<FacePage> pages;
  const NewUserPage({required this.pages, super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _formSubmitted = false;
  String? type;

  List<int> _selectedPages = [];
  List<int> _selectedCommandeTypes = [];
  String error = "";

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
        passwordController.text.isEmpty ||
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: CustomStyledSnackBar(
            message: "remplir les champs manquants ", success: false),
      ));
      return;
    }

    // If all fields are filled, proceed with the submission
    setState(() {
      _formSubmitted = true;
    });
    _submitForm(context);
  }

  void _submitForm(context) {
    if (type == "pageAdmin") {
      List<String> selectedPages = _selectedPages.map((index) {
        return widget.pages[index].id!;
      }).toList();

      // Retrieve selected commande types
      List<String> selectedCommandeTypes = _selectedCommandeTypes.map((index) {
        return commandeTypes[index];
      }).toList();
      UserModel userModel = UserModel(
        username: usernameController.text,
        password: passwordController.text,
        fullname: fullnameController.text,
        role: type,
        pages: selectedPages,
        commandeTypes: selectedCommandeTypes,
      );
      BlocProvider.of<UserBloc>(context).add(
        CreateUserEvent(
          user: userModel,
        ),
      );
    } else {
      UserModel userModel = UserModel(
        username: usernameController.text,
        password: passwordController.text,
        fullname: fullnameController.text,
        role: type,
        pages: const [],
        commandeTypes: const [],
      );
      BlocProvider.of<UserBloc>(context).add(
        CreateUserEvent(
          user: userModel,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const CustomAppBar(titleText: "ajouter un compte"),
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
                    errorText: "Vous devez entrer un mot de passe",
                    controller: passwordController,
                    formSubmitted: _formSubmitted,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocListener<UserBloc, UserBlocState>(
                    listener: (context, state) {
                      if (state is ErrorUserBlocState) {
                        setState(() {
                          error = state.message;
                        });
                      } else if (state is MessageUserBlocState) {
                        Navigator.of(context)
                            .pushReplacementNamed('/accountManager');

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            content: CustomStyledSnackBar(
                                message: "compte ajoutés", success: true),
                          ),
                        );
                      }
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.right,
                      ),
                    ),
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
                    "Ajouter le compte",
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
