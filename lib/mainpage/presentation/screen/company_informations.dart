import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CompanyInformations extends StatefulWidget {
  const CompanyInformations({super.key});

  @override
  State<CompanyInformations> createState() => _CompanyInformationsState();
}

class _CompanyInformationsState extends State<CompanyInformations> {
  String? address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: "Informations de l'entreprise"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              _buildInputField(
                label: "Nom de l'entreprise",
                hintText: "Entrez le nom de l'entreprise",
                errorText: "Vous devez entrer le nom de l'entreprise",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "N° RC",
                hintText: "Numéro de registre de commerce",
                errorText:
                    "Vous devez entrer le Numéro de registre de commerce",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "N° IF",
                hintText: "Numéro d'identifiant fiscale",
                errorText: "Vous devez entrer le Numéro d'identifiant fiscale",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "N° ART",
                hintText: "Entrez le numéro d'ART",
                errorText: "Vous devez entrer le numéro d'ART",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "N° RIB",
                hintText: "Entrez le numéro de RIB",
                errorText: "Vous devez entrer le numéro de RIB",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "Adresse",
                hintText: "Adresse de l'entreprise",
                errorText: "Vous devez entrer l'adresse de l'entreprise",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "N° Tel",
                hintText: "Numéro de telephone de l'entreprise",
                errorText: "Vous devez entrer l'adresse de l'entreprise",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              const SizedBox(
                height: 30,
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
            onPressed: () {
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

  Widget _buildInputField({
    String? label,
    String? hintText,
    String? errorText,
    String? value,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12), // Smaller gap here

        Text(
          label!,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9F9F9F)),
        ),
        // const SizedBox(height: 4), // Smaller gap here
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9F9F9F)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8), // Smaller padding here
            border: const UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 2), // Smaller gap here
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            errorText!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
