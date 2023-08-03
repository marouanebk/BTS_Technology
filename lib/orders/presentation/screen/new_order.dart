import 'package:bts_technologie/orders/presentation/screen/new_factor.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Align the title to the center

        title: const Text(
          "Ajouter une Commande",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),

        elevation: 0.0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  hintText: "- Sélectionnez une page -",
                  errorText: "Vous devez entrer une page",
                  value: selectedPage,
                  onChanged: (value) {
                    setState(() {
                      selectedPage = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Liste d'articles",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9F9F9F)),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 0),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildSelectField(
                        label: "Article",
                        hintText: "- Sélectionnez un article -",
                        errorText: "Vous devez entrer un article",
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
                        hintText: "- Sélectionnez un type -",
                        errorText: "Vous devez entrer un type",
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
                        hintText: "- Sélectionnez une couleur -",
                        errorText: "Vous devez entrer une couleur",
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
                        hintText: "- Sélectionnez une taille -",
                        errorText: "Vous devez entrer une taille",
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
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (_) => const NewFactorPage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    "Enregistrer la commande",
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
