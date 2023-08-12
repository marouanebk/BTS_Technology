import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/logistics_base_screen.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/logistiques/presentation/components/select_field_input.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_bloc.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_event.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_state.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewArticle extends StatefulWidget {
  final String role;
  const NewArticle({required this.role, super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      hasEmptyFields = true;
    }

    // Check if any variant is added and if any of the variant fields are empty
    if (variants.isEmpty) {
      hasEmptyFields = true;
    } else {
      for (var variant in variants) {
        if (variant.nomCouleurController.text.isEmpty ||
            variant.codeCouleurController.text.isEmpty ||
            variant.tailleController.text.isEmpty ||
            variant.quantiteController.text.isEmpty ||
            variant.family == null) {
          hasEmptyFields = true;
          break;
        }
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
      child: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state.createArticleState == RequestState.loaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                if (widget.role == "logistics") {
                  return const LogistiquesBaseScreen(initialIndex: 2);
                } else {
                  return const PageAdministratorBaseScreen(initialIndex: 3);
                }
              }),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.transparent,
                content: CustomStyledSnackBar(
                    message: "Command ajoutés", success: true),
              ),
            );
          } else if (state.createArticleState == RequestState.error) {
            SnackBar(
              backgroundColor: Colors.transparent,
              content: CustomStyledSnackBar(
                  message: state.createArticleMessage, success: true),
            );
          }
        },
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
                      buildInputField(
                          label: "Nom de l'article",
                          hintText: "Entrez le nom de l'article",
                          errorText: "Vous devez entrer une nom",
                          controller: nomArticleController,
                          formSubmitted: _formSubmitted),
                      const SizedBox(height: 20),
                      buildInputField(
                        label: "Unité",
                        hintText: "Entrez l'unité",
                        errorText: "Vous devez entrer une Unité",
                        controller: uniteController,
                        formSubmitted: _formSubmitted,
                      ),
                      const SizedBox(height: 20),
                      buildInputField(
                          label: "Prix d'achat",
                          hintText: "Entrez le prix d'achat",
                          errorText: "Vous devez entrer le prix d'achat",
                          controller: prixAchatController,
                          isNumeric: true,
                          formSubmitted: _formSubmitted),
                      const SizedBox(height: 20),
                      buildInputField(
                          label: "Prix de ventre en gros",
                          hintText: "Entrez le prix de vente en gros",
                          errorText:
                              "Vous devez entrer le prix de vente en gros",
                          controller: prixGrosController,
                          isNumeric: true,
                          formSubmitted: _formSubmitted),
                      const SizedBox(height: 20),
                      buildInputField(
                          label: "Quantité d'alerte",
                          hintText: "Entrez la quantité d'alerte",
                          errorText: "Vous devez entrer la quantité d'alerte",
                          controller: quanAlertController,
                          isNumeric: true,
                          formSubmitted: _formSubmitted),
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
      ),
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
              buildInputField(
                label: "Nom de la couleur",
                hintText: "Entrez le nom de la couleur",
                errorText: "Vous devez entrer le nom de la couleur",
                controller: variant
                    .nomCouleurController, // Use variant controller                      formSubmitted: _formSubmitted
              ),
              const SizedBox(height: 18),
              buildInputField(
                label: "Code de la couleur",
                hintText: "Entrez le code HEX de la couleur",
                errorText: "Vous devez entrer un code HEX valide",
                controller: variant
                    .codeCouleurController, // Use variant controller                      formSubmitted: _formSubmitted
              ),
              const SizedBox(height: 18),
              buildInputField(
                label: "Taille",
                hintText: "Entrez la taille",
                errorText: "Vous devez entrer une taille",
                controller: variant
                    .tailleController, // Use variant controller                      formSubmitted: _formSubmitted
              ),
              const SizedBox(height: 18),
              buildInputField(
                  label: "Quantité",
                  hintText: "Entrez la Quantité",
                  errorText: "Vous devez entrer la Quantité",
                  controller: variant.quantiteController,
                  isNumeric: true,
                  formSubmitted: _formSubmitted),
              const SizedBox(height: 18),
              buildSelectField(
                label: "Famille",
                hintText: "- selectioner ume famille d'articles",
                errorText: "Vous devez entrer une page",
                value: variant.family,
                formSubmitted: _formSubmitted,
                items: [
                  {"label": "Regular", "value": "regular"},
                  {"label": "Oversize", "value": "oversize"},
                ],
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
                icon: const Icon(Icons.clear, color: Colors.white),
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
