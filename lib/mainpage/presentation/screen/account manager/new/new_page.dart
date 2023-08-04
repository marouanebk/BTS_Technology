import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NewPageAccount extends StatefulWidget {
  const NewPageAccount({super.key});

  @override
  State<NewPageAccount> createState() => _NewPageAccountState();
}

class _NewPageAccountState extends State<NewPageAccount> {
  String? address = '';

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
              _buildInputField(
                label: "Nom de la page",
                hintText: "Entrez le nom complet",
                errorText: "Vous devez entrer le nom",
                value: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
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
}
