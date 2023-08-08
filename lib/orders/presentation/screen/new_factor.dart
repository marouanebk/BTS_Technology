import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/components/factor_container.dart';
import 'package:flutter/material.dart';
import 'package:bts_technologie/facture/api/pdf_invoice_api.dart';

class NewFactorPage extends StatefulWidget {
  final Command command;
  const NewFactorPage({required this.command, super.key});

  @override
  State<NewFactorPage> createState() => _NewFactorPageState();
}

class _NewFactorPageState extends State<NewFactorPage> {
  final pdfApi = PdfInvoiceApi();

  TextEditingController rcController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController naiController = TextEditingController();
  TextEditingController nifController = TextEditingController();
  bool _formSubmitted = false;

  @override
  void dispose() {
    rcController.dispose();
    nisController.dispose();
    naiController.dispose();
    nifController.dispose();

    super.dispose();
  }

  void _checkFormValidation(context) {
    bool hasEmptyFields = false;

    // Check if any of the input fields are empty
    if (rcController.text.isEmpty ||
        nisController.text.isEmpty ||
        nifController.text.isEmpty ||
        naiController.text.isEmpty) {
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

  void _submitForm(context) {
    Future<void> createAndOpenPdf() async {
      // final File? pdfFile =
      // await pdfApi.generate(widget.command);
    }
    // UserModel userModel = UserModel(
    //   username: usernameController.text,
    //   password: passwordController.text,
    //   fullname: fullnameController.text,
    //   role: type,
    // );
    // BlocProvider.of<UserBloc>(context).add(
    //   CreateUserEvent(
    //     user: userModel,
    //   ),
    // );
  }

  String? nomClient = '';
  String? rc = '';
  String? nis = '';
  String? nif = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        titleText: "Générer une facture",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                factorContainer(),
                const SizedBox(height: 30),
                buildInputField(
                  label: "R.C",
                  hintText: "Numéro de registre de commerce",
                  errorText: "Vous devez entrer le nom de l'entreprise",
                  controller: rcController,
                  formSubmitted: _formSubmitted,
                ),
                buildInputField(
                  label: "NIS",
                  hintText: "Numéro d'identifiant statistique",
                  errorText: "Vous devez entrer le nom de l'entreprise",
                  controller: rcController,
                  formSubmitted: _formSubmitted,
                ),
                buildInputField(
                  label: "NIF",
                  hintText: "Numéro d'identifiant fiscale",
                  errorText: "Vous devez entrer le nom de l'entreprise",
                  controller: rcController,
                  formSubmitted: _formSubmitted,
                ),
                buildInputField(
                  label: "N° AI",
                  hintText: "Numero d'article d'imposition",
                  errorText: "Vous devez entrer le nom de l'entreprise",
                  controller: rcController,
                  formSubmitted: _formSubmitted,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50, // Set the height to 50
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ElevatedButton(
                  onPressed: () async {
                    // _submitForm(context);
                    // await pdfApi.generate(widget.command);
                    // Navigator.of(context, rootNavigator: true).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => const NewFactorPage(),
                    //   ),
                    // );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    "Telecharger la facture",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
