import 'dart:developer';

import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  String? address = '';
  List<int> _selectedValues = []; // Initialize the list here

  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
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
              _buildSelectField(
                label: "Type ",
                hintText: "- Sélectionnez une type de compte -",
                errorText: "Vous devez entrer une type",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "Nom complet",
                hintText: "Entrez le nom complet",
                errorText: "Vous devez entrer le nom complet",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "Nom d'utilisateur",
                hintText: "Entrez le pseudo utilisé pour s'inscrire",
                errorText: "Vous devez entrer le Nom d'utilisateur",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildInputField(
                label: "Mot de passe",
                hintText: "Entrez le mot de passe du compte",
                errorText: "Vous devez entrer un mot de passe",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              Column(
                children: <Widget>[
                  for (int i = 1; i <= 5; i++)
                    ListTile(
                      title: Text('Radio $i'),
                      leading: Radio(
                        value: i,
                        groupValue: _selectedValues.contains(i) ? i : null,
                        toggleable: true,
                        onChanged: (int? value) {
                          log('Radio $value clicked');
                          log(value.toString());
                          log(_selectedValues.toString());

                          setState(() {
                            if (_selectedValues.contains(value)) {
                              _selectedValues
                                  .remove(value); // Unselect the value
                            } else {
                              _selectedValues
                                  .add(value!); // Select the new value
                            }
                          });
                        },
                        //
                        activeColor: Colors.blue,
                      ),
                    ),
                ],
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
              "Ajouter le compte",
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
        Text(
          label!,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9F9F9F)),
        ),
        const SizedBox(height: 4), // Smaller gap here
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

  Widget _buildSelectField({
    required String label,
    required String hintText,
    required String? value,
    required String errorText,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9F9F9F)),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              hint: Text(hintText),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              items: const [],
              // Add your DropdownMenuItem items here
            ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            errorText,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
