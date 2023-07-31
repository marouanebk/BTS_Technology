import 'package:flutter/material.dart';

class AddOrderPage extends StatefulWidget {
  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  String? address = '';
  String? phoneNumber = '';
  String? sum = '';
  String? selectedPage = '';
  String? selectedArticle = '';
  String? selectedType = '';
  String? selectedColor = '';
  String? selectedSize = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Ajouter une Commande",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildInputField(
              label: "Adresse",
              hintText: "Entrez une adresse",
              errorText: "Vous devez entrer une adresse",
              value: address,
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildInputField(
              label: "Numéro de téléphone",
              hintText: "Entrez un numéro de téléphone",
              errorText: "Vous devez entrer un numéro de téléphone",
              value: phoneNumber,
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildInputField(
              label: "Somme versée",
              hintText: "Entrez une somme versée",
              errorText: "Vous devez entrer une somme versée",
              value: sum,
              onChanged: (value) {
                setState(() {
                  sum = value;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildSelectField(
              label: "Sélectionner une page",
              hintText: "Sélectionnez une page",
              value: selectedPage,
              onChanged: (value) {
                setState(() {
                  selectedPage = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSelectField(
                    label: "Article",
                    hintText: "Sélectionnez un article",
                    value: selectedArticle,
                    onChanged: (value) {
                      setState(() {
                        selectedArticle = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSelectField(
                    label: "Type",
                    hintText: "Sélectionnez un type",
                    value: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSelectField(
                    label: "Couleur",
                    hintText: "Sélectionnez une couleur",
                    value: selectedColor,
                    onChanged: (value) {
                      setState(() {
                        selectedColor = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSelectField(
                    label: "Taille",
                    hintText: "Sélectionnez une taille",
                    value: selectedSize,
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add your logic for saving the command here
                },
                child: const Text("Enregistrer la commande"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  
                ),
              ),
            ),
          ],
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
                EdgeInsets.symmetric(vertical: 8), // Smaller padding here
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
              items: [],
              // Add your DropdownMenuItem items here
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "errorText",
            style:  TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
