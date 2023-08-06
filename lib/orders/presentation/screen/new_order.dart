import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/logistiques/presentation/components/select_field_input.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/orders/presentation/screen/new_factor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddOrderPage extends StatefulWidget {
  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController adresssController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController sommePaidController = TextEditingController();
  TextEditingController noteClientController = TextEditingController();
  bool _formSubmitted = false;

  String? address;
  String? phoneNumber;
  String? sum;
  String? selectedPage;
  String? selectedArticle;
  String? selectedType;
  String? selectedColor;
  String? selectedSize;

  List<ArticleItem> variants = [];
  int count = 1;

  @override
  void dispose() {
    fullnameController.dispose();
    adresssController.dispose();
    phonenumberController.dispose();
    sommePaidController.dispose();
    noteClientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(titleText: "Ajouter une Commande"),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                buildInputField(
                  label: "Nom complet",
                  hintText: "Entrez le nom du client",
                  errorText: "Vous devez entrer le nom",
                  controller: fullnameController,
                  formSubmitted: _formSubmitted,
                ),
                const SizedBox(height: 15),
                buildInputField(
                  label: "Adresse",
                  hintText: "Entrez l'adresse de livraison",
                  errorText: "Vous devez entrer une adresse",
                  controller: adresssController,
                  formSubmitted: _formSubmitted,
                ),
                const SizedBox(height: 15),
                buildInputField(
                  label: "Numéro de téléphone",
                  hintText: "Entrez un numéro de téléphone",
                  errorText: "Vous devez entrer un numéro de téléphone",
                  controller: fullnameController,
                  formSubmitted: _formSubmitted,
                  isNumeric: true,
                ),
                const SizedBox(height: 15),
                buildInputField(
                  label: "Somme versée",
                  hintText: "Entrez une somme versée",
                  errorText: "Vous devez entrer une somme versée",
                  controller: fullnameController,
                  formSubmitted: _formSubmitted,
                  isNumeric: true,
                  isMoney: true,
                ),
                const SizedBox(height: 15),
                buildSelectField(
                  label: "Sélectionner une page",
                  hintText: "- Sélectionnez une page -",
                  errorText: "Vous devez entrer une page",
                  value: selectedPage,
                  onChanged: (value) {
                    setState(() {
                      selectedPage = value;
                    });
                  },
                  formSubmitted: _formSubmitted,
                  items: [
                    {"label": "1", "value": "1"},
                    {"label": "1", "value": "1"},
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "Liste d'articles",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9F9F9F)),
                ),
                const SizedBox(height: 10),
                articleContainer(),
                const SizedBox(
                  height: 20,
                ),
                _addArticleItem(),
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

  Widget articleContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 0),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: const Color(0xFF9F9F9F)),
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildSelectField(
            label: "Article",
            hintText: "- Sélectionnez un article -",
            errorText: "Vous devez entrer un article",
            value: selectedArticle,
            onChanged: (value) {
              setState(() {
                selectedArticle = value;
              });
            },
            formSubmitted: _formSubmitted,
            items: [
              {"label": "2", "value": "2"},
              {"label": "2", "value": "2"},
            ],
          ),
          const SizedBox(height: 15),
          buildSelectField(
            label: "Type",
            hintText: "- Sélectionnez un type -",
            errorText: "Vous devez entrer un type",
            value: selectedType,
            onChanged: (value) {
              setState(() {
                selectedType = value;
              });
            },
            formSubmitted: _formSubmitted,
            items: [
              {"label": "3", "value": "3"},
              {"label": "3", "value": "3"},
            ],
          ),
          const SizedBox(height: 15),
          buildSelectField(
            label: "Couleur",
            hintText: "- Sélectionnez une couleur -",
            errorText: "Vous devez entrer une couleur",
            value: selectedColor,
            onChanged: (value) {
              setState(() {
                selectedColor = value;
              });
            },
            formSubmitted: _formSubmitted,
            items: [
              {"label": "4", "value": "4"},
              {"label": "4", "value": "4"},
            ],
          ),
          const SizedBox(height: 15),
          buildSelectField(
            label: "Taille",
            hintText: "- Sélectionnez une taille -",
            errorText: "Vous devez entrer une taille",
            value: selectedSize,
            onChanged: (value) {
              setState(() {
                selectedSize = value;
              });
            },
            formSubmitted: _formSubmitted,
            items: [
              {"label": "5", "value": "5"},
              {"label": "5", "value": "5"},
            ],
          ),
          const SizedBox(height: 15),
          buildSelectField(
            label: "Famille",
            hintText: "- Sélectionnez une famille -",
            errorText: "Vous devez entrer une famille -",
            value: selectedSize,
            onChanged: (value) {
              setState(() {
                selectedSize = value;
              });
            },
            formSubmitted: _formSubmitted,
            items: [
              {"label": "5", "value": "5"},
              {"label": "5", "value": "5"},
            ],
          ),
          const SizedBox(height: 15),
          buildInputField(
            label: "Prix",
            hintText: "Entrer le prix d'un seul article",
            errorText: "Vous devez entrer un prix",
            controller: fullnameController,
            formSubmitted: _formSubmitted,
            isNumeric: true,
          ),
          const SizedBox(height: 15),
          buildInputField(
            label: "Nbr d'articles",
            hintText: "Le nombre d'articles",
            errorText: "Vous devez entrer le nombre d'articles",
            controller: fullnameController,
            formSubmitted: _formSubmitted,
            isNumeric: true,
          ),
          _imagePickerContainer(),
          Wrap(
            spacing: 8.0, // Adjust spacing between images
            runSpacing: 8.0, // Adjust spacing between lines
            children: [
              ...List.generate(
                5,
                (index) => InkWell(
                  onTap: () {},
                  child: Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color(0xFFECECEC),
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/tshirt_2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addArticleItem() {
    return InkWell(
      onTap: () {
        setState(() {
          variants.add(ArticleItem());
        });
      },
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFF0066FF).withOpacity(0.1),
          ),
          child: const Center(
            child: Text(
              'Ajouter un variant',
              style: TextStyle(
                color: Color(0xFF0066FF),
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          )),
    );
  }

  Widget _imagePickerContainer() {
    return InkWell(
      onTap: () => _selectImage(context),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF0066FF).withOpacity(0.1),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              color: Color(0xFF0066FF),
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Ajouter des photos',
              style: TextStyle(
                color: Color(0xFF0066FF),
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Perform operations with the selected image.
    }
  }
}

class ArticleItem {
  TextEditingController prixController = TextEditingController();
  TextEditingController nbrArticlesController = TextEditingController();
  String? article;
  String? type;
  String? couleur;
  String? taille;
  String? famille;
}
