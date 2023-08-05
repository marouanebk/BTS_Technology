import 'dart:developer';

import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_bloc.dart';
import 'package:bts_technologie/logistiques/presentation/controller/todo_bloc/article_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewArticle extends StatefulWidget {
  @override
  _NewArticleState createState() => _NewArticleState();
}

class _NewArticleState extends State<NewArticle> {
  TextEditingController nomArticleController = TextEditingController();
  TextEditingController uniteController = TextEditingController();
  TextEditingController prixAchatController = TextEditingController();
  TextEditingController prixGrosController = TextEditingController();
  TextEditingController quanAlertController = TextEditingController();

  List<VariantItem> variants = [];
  int count = 1;

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    nomArticleController.dispose();
    uniteController.dispose();
    prixAchatController.dispose();
    prixGrosController.dispose();
    quanAlertController.dispose();

    super.dispose();
  }

  bool _formSubmitted = false;

  void _checkFormValidation(context) {
    bool hasEmptyFields = false;

    // Check if any of the input fields are empty
    if (nomArticleController.text.isEmpty ||
        uniteController.text.isEmpty ||
        prixAchatController.text.isEmpty ||
        prixGrosController.text.isEmpty ||
        quanAlertController.text.isEmpty) {
      setState(() {
        hasEmptyFields = true;
      });
    }
  

    for (var variant in variants) {
      if (variant.nomCouleurController.text.isEmpty ||
          variant.codeCouleurController.text.isEmpty ||
          variant.tailleController.text.isEmpty ||
          variant.quantiteController.text.isEmpty ||
          variant.family == null) {
        setState(() {
          hasEmptyFields = true;
        });
        break;
      }
    }

    // If there are empty fields, do not proceed with the submission
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
    final articleModel = ArticleModel(
      name: nomArticleController.text,
      unity: uniteController.text,
      buyingPrice: double.parse(prixAchatController.text),
      grosPrice: double.parse(prixGrosController.text),
      alertQuantity: int.parse(quanAlertController.text),
      variants: variants.map((variant) {
        return Variant(
          colour: variant.nomCouleurController.text,
          colourCode: variant.codeCouleurController.text,
          taille: variant.tailleController.text,
          quantity: int.parse(variant.quantiteController
              .text), // Note: this should be a String, not int.parse
          family: variant.family!,
        );
      }).toList(),
    );

    log(articleModel.toJson().toString());

    BlocProvider.of<ArticleBloc>(context).add(
      CreateArticleEvent(
        article: articleModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticleBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true, // Align the title to the center

            title: const Text(
              "Ajouter un article",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // backgroundColor:
            //     Colors.blue.withOpacity(0.3), //You can make this transparent
            elevation: 0.0,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(right: 20.0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: "Nom de l'article",
                      hintText: "Entrez le nom de l'article",
                      errorText: "Vous devez entrer une nom",
                      controller: nomArticleController,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: "Unité",
                      hintText: "Entrez l'unité",
                      errorText: "Vous devez entrer une Unité",
                      controller: uniteController,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: "Prix d'achat",
                      hintText: "Entrez le prix d'achat",
                      errorText: "Vous devez entrer le prix d'achat",
                      controller: prixAchatController,
                      isNumeric: true,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: "Prix de ventre en gros",
                      hintText: "Entrez le prix de vente en gros",
                      errorText: "Vous devez entrer le prix de vente en gros",
                      controller: prixGrosController,
                      isNumeric: true,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: "Quantité d'alerte",
                      hintText: "Entrez la quantité d'alerte",
                      errorText: "Vous devez entrer la quantité d'alerte",
                      controller: quanAlertController,
                      isNumeric: true,
                    ),
                    const SizedBox(height: 20),
                    _imagePickerContainer(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Variants",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9F9F9F)),
                    ),
                    const SizedBox(height: 10),
                    // _variantContainer(),
                    _variantContainerList(),
                    const SizedBox(height: 20),
                    _addVariantContainer(),
                    const SizedBox(height: 80),
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
                        _checkFormValidation(context);
                      },
                      // onPressed: () {
                      //   // Navigator.of(context, rootNavigator: true).push(
                      //   //   MaterialPageRoute(
                      //   //     builder: (_) => const NewFactorPage(),
                      //   //   ),
                      //   // );

                      // },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text(
                        "Ajouter l'article",
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
      }),
    );
  }

  Widget _variantContainerList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: variants.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _variantContainer(variants[index]);
      },
    );
  }

  Widget _addVariantContainer() {
    return InkWell(
      onTap: () {
        log("clicking the button on the");
        setState(() {
          variants.add(VariantItem());
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
              'Ajouter une photo',
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

  Widget _variantContainer(VariantItem variant) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInputField(
                label: "Nom de la couleur",
                hintText: "Entrez le nom de la couleur",
                errorText: "Vous devez entrer le nom de la couleur",
                controller:
                    variant.nomCouleurController, // Use variant controller
              ),
              const SizedBox(height: 18),
              _buildInputField(
                label: "Code de la couleur",
                hintText: "Entrez le code HEX de la couleur",
                errorText: "Vous devez entrer un code HEX valide",
                controller:
                    variant.codeCouleurController, // Use variant controller
              ),
              const SizedBox(height: 18),
              _buildInputField(
                label: "Taille",
                hintText: "Entrez la taille",
                errorText: "Vous devez entrer une taille",
                controller: variant.tailleController, // Use variant controller
              ),
              const SizedBox(height: 18),
              _buildInputField(
                label: "Quantité",
                hintText: "Entrez la Quantité",
                errorText: "Vous devez entrer la Quantité",
                controller: variant.quantiteController,
                isNumeric: true,
              ),
              const SizedBox(height: 18),
              _buildSelectField(
                label: "Famille",
                hintText: "- selectioner ume famille d'articles",
                errorText: "Vous devez entrer une page",
                value: variant.family,
                onChanged: (value) {
                  setState(() {
                    variant.family = value;
                  });
                },
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  setState(() {
                    variants.remove(variant);
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    String? label,
    String? hintText,
    String? errorText,
    TextEditingController? controller,
    bool isNumeric =
        false, // New parameter for specifying if it's a numeric field
  }) {
    // Check if the field is empty to show the error text
    final bool isEmpty = controller?.text.isEmpty ?? false;

    // Show the error text only if the form has been submitted and the field is empty
    final bool showErrorText = _formSubmitted && isEmpty;

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
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: controller,
              keyboardType:
                  isNumeric ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9F9F9F)),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: const UnderlineInputBorder(),
              ),
            ),
            // Show "DA" at the end for numeric fields (isNumeric = true)
            if (isNumeric)
              const Positioned(
                right: 0,
                child: Text(
                  "DA",
                  style: TextStyle(color: Colors.black),
                ),
              ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            showErrorText ? errorText! : "",
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
    // Check if the field is empty to show the error text
    final bool isEmpty = value?.isEmpty ?? true;

    // Show the error text only if the form has been submitted and the field is empty
    final bool showErrorText = _formSubmitted && isEmpty;

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
              items: const [
                DropdownMenuItem<String>(
                  value: "regular",
                  child: Text("Regular"),
                ),
                DropdownMenuItem<String>(
                  value: "oversize",
                  child: Text("Oversize"),
                ),
              ],
              // Add your DropdownMenuItem items here
            ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            showErrorText ? errorText : "",
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
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

class VariantItem {
  TextEditingController nomCouleurController = TextEditingController();
  TextEditingController codeCouleurController = TextEditingController();
  TextEditingController tailleController = TextEditingController();
  TextEditingController quantiteController = TextEditingController();
  String? family;
}
