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

class CompanyInformations extends StatefulWidget {
  const CompanyInformations({super.key});

  @override
  State<CompanyInformations> createState() => _CompanyInformationsState();
}

class _CompanyInformationsState extends State<CompanyInformations> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberRCController = TextEditingController();
  TextEditingController numberIFController = TextEditingController();
  TextEditingController numberARTController = TextEditingController();
  TextEditingController numberRIBController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool _formSubmitted = false;

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    nameController.dispose();
    numberRCController.dispose();
    numberIFController.dispose();
    numberARTController.dispose();
    numberRIBController.dispose();
    adresseController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _checkFormValidation(context) {
    bool hasEmptyFields = false;

    // Check if any of the input fields are empty
    if (nameController.text.isEmpty ||
        numberRCController.text.isEmpty ||
        numberIFController.text.isEmpty ||
        numberARTController.text.isEmpty ||
        numberRIBController.text.isEmpty ||
        adresseController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().post(ApiConstance.updateEntrepriseApi,
        data: {
          "name": nameController.text,
          "numberRC": int.parse(numberRCController.text),
          "numberIF": int.parse(numberIFController.text),
          "numberART": int.parse(numberARTController.text),
          "numberRIB": int.parse(numberRIBController.text),
          "adresse": adresseController.text,
          "phoneNumber": int.parse(phoneNumberController.text),
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      Navigator.popUntil(
          context, (route) => route.settings.name == '/accountManager');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          content: CustomStyledSnackBar(message: "Information Modifier", success: true),
        ),
      );
    } else {
      CustomStyledSnackBar(message: response.data['err'], success: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AccountBloc>()..add(GetEntrepriseInfoEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const CustomAppBar(titleText: "Informations de l'entreprise"),
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state.getEntrepriseInfoState == RequestState.loaded) {
                nameController.text = state.getEntrepriseInfo?.name ?? '';
                if (state.getEntrepriseInfo!.numberRC != null) {
                  numberRCController.text =
                      state.getEntrepriseInfo!.numberRC.toString();
                }
                if (state.getEntrepriseInfo!.numberART != null) {
                  numberARTController.text =
                      state.getEntrepriseInfo!.numberART.toString();
                }
                if (state.getEntrepriseInfo!.numberRIB != null) {
                  numberRIBController.text =
                      state.getEntrepriseInfo!.numberRIB.toString();
                }
                if (state.getEntrepriseInfo!.numberIF != null) {
                  numberIFController.text =
                      state.getEntrepriseInfo!.numberIF.toString();
                }
                if (state.getEntrepriseInfo!.phoneNumber != null) {
                  phoneNumberController.text =
                      state.getEntrepriseInfo!.phoneNumber.toString();
                }

                adresseController.text = state.getEntrepriseInfo?.adresse ?? "";

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        buildInputField(
                          label: "Nom de l'entreprise",
                          hintText: "Entrez le nom de l'entreprise",
                          errorText: "Vous devez entrer le nom de l'entreprise",
                          controller: nameController,
                          formSubmitted: _formSubmitted,
                        ),
                        buildInputField(
                          label: "N° RC",
                          hintText: "Numéro de registre de commerce",
                          errorText:
                              "Vous devez entrer le Numéro de registre de commerce",
                          controller: numberRCController,
                          formSubmitted: _formSubmitted,
                          isNumeric: true,
                        ),
                        buildInputField(
                            label: "N° IF",
                            hintText: "Numéro d'identifiant fiscale",
                            errorText:
                                "Vous devez entrer le Numéro d'identifiant fiscale",
                            controller: numberIFController,
                            formSubmitted: _formSubmitted,
                            isNumeric: true),
                        buildInputField(
                          label: "N° ART",
                          hintText: "Entrez le numéro d'ART",
                          errorText: "Vous devez entrer le numéro d'ART",
                          controller: numberARTController,
                          formSubmitted: _formSubmitted,
                          isNumeric: true,
                        ),
                        buildInputField(
                          label: "N° RIB",
                          hintText: "Entrez le numéro de RIB",
                          errorText: "Vous devez entrer le numéro de RIB",
                          controller: numberRIBController,
                          formSubmitted: _formSubmitted,
                          isNumeric: true,
                        ),
                        buildInputField(
                          label: "Adresse",
                          hintText: "Adresse de l'entreprise",
                          errorText:
                              "Vous devez entrer l'adresse de l'entreprise",
                          controller: nameController,
                          formSubmitted: _formSubmitted,
                        ),
                        buildInputField(
                          label: "N° Tel",
                          hintText: "Numéro de telephone de l'entreprise",
                          errorText:
                              "Vous devez entrer l'adresse de l'entreprise",
                          controller: phoneNumberController,
                          formSubmitted: _formSubmitted,
                          isNumeric: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        registerButton(context),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state.getEntrepriseInfoState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      }),
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
            onPressed: () {
              _checkFormValidation(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Text(
              "Enregister",
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
