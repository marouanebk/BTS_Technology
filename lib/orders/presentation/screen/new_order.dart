import 'dart:developer';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:bts_technologie/base_screens/admin_base_screen.dart';
import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/finances_base_screen.dart';
import 'package:bts_technologie/base_screens/logistics_base_screen.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:bts_technologie/logistiques/presentation/components/input_field_widget.dart';
import 'package:bts_technologie/logistiques/presentation/components/select_field_input.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_bloc.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_event.dart';
import 'package:bts_technologie/logistiques/presentation/controller/article_bloc/article_state.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_bloc.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_event.dart';
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_bloc.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_event.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddOrderPage extends StatefulWidget {
  final String role;
  const AddOrderPage({required this.role, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController adresssController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController sommePaidController = TextEditingController();
  TextEditingController noteClientController = TextEditingController();
  // TextEditingController prixSoutraitantController = TextEditingController();
  bool _formSubmitted = false;

  String? selectedPage;

  List<ArticleItem> variants = [];
  int count = 1;

  @override
  void initState() {
    super.initState();
    if (widget.role == "pageAdmin") {
      commandTypesEnum = []; // Initialize it to an empty list
      selectedPage = null; // Initialize it to null
    }
  }

  @override
  void dispose() {
    fullnameController.dispose();
    adresssController.dispose();
    phonenumberController.dispose();
    sommePaidController.dispose();
    noteClientController.dispose();
    super.dispose();
  }

  List<Map<String, String>> selectedPagesEnum = [];

  List<Map<String, String>> commandTypesEnum = [
    {"label": "Vierge détail", "value": "Vierge détail"},
    {"label": "Personnalisé détail", "value": "Personnalisé détail"},
    {"label": "Gros personnalisé", "value": "Gros personnalisé"},
    {"label": "Gros détail", "value": "Gros détail"},
  ];

  int totalImagesFilesCount = 0;

  List<Article> articles = [];
  List<Map<String, String>> articlesList = [];
  List<Map<String, String>> variantsList = [];

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  void _checkFormValidation(context) {
    bool hasEmptyFields = false;
    bool hasInvalidNumericFields = false; // Add this line

    // Check if any of the input fields are empty
    if (fullnameController.text.isEmpty ||
        adresssController.text.isEmpty ||
        phonenumberController.text.isEmpty ||
        sommePaidController.text.isEmpty) {
      // noteClientController.text.isEmpty ) {
      hasEmptyFields = true;
    }

    if (!isNumeric(sommePaidController.text)) {
      hasEmptyFields = true;
      hasInvalidNumericFields = true;
    }

    // Check if any variant is added and if any of the variant fields are empty
    if (variants.isEmpty) {
      hasEmptyFields = true;
    } else {
      for (var variant in variants) {
        if (variant.prixController.text.isEmpty ||
            variant.nbrArticlesController.text.isEmpty ||
            variant.article == null ||
            variant.type == null) {
          hasEmptyFields = true;
          break;
        }
      }
    }

    if (variants.isEmpty) {
      hasEmptyFields = true;
    } else {
      for (var variant in variants) {
        if (!isNumeric(variant.prixController.text) ||
            !isNumeric(variant.nbrArticlesController.text)) {
          hasInvalidNumericFields = true;
          hasEmptyFields = true;
          break;
        }
      }
    }

    // If there are empty fields, do not proceed with the submission
    if (hasEmptyFields || hasInvalidNumericFields) {
      setState(() {
        _formSubmitted = true;
      });
      return;
    }

    // If all fields are filled, proceed with the submission
    setState(() {
      _formSubmitted = true;
    });
    submitForm(context);
  }

  void submitForm(context) {
    CommandModel commandModel;
    if (selectedPage != null) {
      commandModel = CommandModel(
        adresse: adresssController.text,
        nomClient: fullnameController.text,
        phoneNumber: int.parse(phonenumberController.text),
        noteClient: noteClientController.text,
        page: selectedPage,
        sommePaid: double.parse(sommePaidController.text),
        articleList: variants.map((variant) {
          return CommandArticle(
            quantity: int.parse(variant.nbrArticlesController.text),
            articleId: variant.article!,
            unityPrice: double.parse(variant.prixController.text),
            commandType: variant.type!,
            variantId: variant.variant!,
            files: variant.files.map((xFile) => File(xFile.path)).toList(),
          );
        }).toList(),
      );
    } else {
      commandModel = CommandModel(
        adresse: adresssController.text,
        nomClient: fullnameController.text,
        phoneNumber: int.parse(phonenumberController.text),
        noteClient: noteClientController.text,
        sommePaid: double.parse(sommePaidController.text),
        articleList: variants.map((variant) {
          return CommandArticle(
            quantity: int.parse(variant.nbrArticlesController.text),
            articleId: variant.article!,
            unityPrice: double.parse(variant.prixController.text),
            commandType: variant.type!,
            variantId: variant.variant!,
            files: variant.files.map((xFile) => File(xFile.path)).toList(),
          );
        }).toList(),
      );
    }

    BlocProvider.of<CommandBloc>(context)
        .add(CreateCommandEvent(command: commandModel));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ArticleBloc>()..add(GetArticlesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<CommandBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AccountBloc>()..add(GetUserInfoEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state.getUserInfoState == RequestState.loaded) {
                log("state loaded");
                if (widget.role == "pageAdmin") {
                  // Retrieve userInfo.pages and userInfo.commandTypes
                  final adminPages = state.getUserInfo!.populatedpages!;
                  final adminCommandTypes = state.getUserInfo!.commandeTypes!;
                  final validCommandTypes =
                      adminCommandTypes.where((type) => type != null).toList();

                  selectedPagesEnum = adminPages.map((page) {
                    return {
                      "label": page.pageName.toString(),
                      "value": page.id.toString()
                    };
                  }).toList();

                  commandTypesEnum = validCommandTypes.map((type) {
                    return {"label": type!, "value": type};
                  }).toList();
                  setState(() {});
                }
              }
            },
          ),
          BlocListener<ArticleBloc, ArticleState>(
            listener: (context, state) {
              if (state.getArticlesState == RequestState.loaded) {
                articles = state.getArticles;
                articlesList = articles.map((article) {
                  return {
                    'label': article.name ?? "",
                    'value': article.id ?? "",
                  };
                }).toList();
              }
            },
          ),
          BlocListener<CommandBloc, CommandesState>(
            listener: (context, state) {
              if (state.createCommandState == RequestState.loaded) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    if (widget.role == "financier") {
                      return const FinancesBaseScreen(initialIndex: 0);
                    } else if (widget.role == "pageAdmin") {
                      return const AdminPageBaseScreen(initialIndex: 0);
                    } else if (widget.role == "logistics") {
                      return const LogistiquesBaseScreen(initialIndex: 0);
                    } else {
                      return const PageAdministratorBaseScreen(initialIndex: 1);
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
              } else if (state.createCommandState == RequestState.error) {
                SnackBar(
                  backgroundColor: Colors.transparent,
                  content: CustomStyledSnackBar(
                      message: state.createCommandMessage, success: false),
                );
              }
            },
          ),
        ],
        child: Builder(builder: (context) {
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
                        controller: phonenumberController,
                        formSubmitted: _formSubmitted,
                        isNumeric: true,
                      ),
                      const SizedBox(height: 15),
                      buildInputField(
                        label: "Somme versée",
                        hintText: "Entrez une somme versée",
                        errorText: "Vous devez entrer une somme versée",
                        controller: sommePaidController,
                        formSubmitted: _formSubmitted,
                        isNumeric: true,
                        isMoney: true,
                      ),
                      const SizedBox(height: 15),
                      buildInputField(
                        label: "note Client",
                        hintText: "Entrez la note du client",
                        errorText: "",
                        controller: noteClientController,
                        formSubmitted: _formSubmitted,
                        isNumeric: false,
                        isMoney: false,
                      ),
                      const SizedBox(height: 15),
                      if (widget.role == "pageAdmin") ...[
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
                            items: selectedPagesEnum),
                      ],
                      const SizedBox(height: 15),
                      const Text(
                        "Liste d'articles",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF9F9F9F)),
                      ),
                      const SizedBox(height: 10),
                      _variantContainerList(),
                      // articleContainer(),
                      const SizedBox(
                        height: 20,
                      ),
                      _addArticleItem(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
                BlocBuilder<CommandBloc, CommandesState>(
                    builder: (context, state) {
                  if (state.createCommandState == RequestState.error) {
                    return Text(
                      state.createCommandMessage,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return Container();
                }),
                BlocBuilder<CommandBloc, CommandesState>(
                  builder: (context, state) {
                    if (state.createCommandState == RequestState.loading) {
                      // Display the button style with the circular indicator
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    // When not in loading state, show the button
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: ElevatedButton(
                            onPressed: () {
                              _checkFormValidation(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
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
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _variantContainerList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      shrinkWrap: true,
      itemCount: variants.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return articleContainer(variants[index]);
      },
    );
  }

  Widget articleContainer(ArticleItem article) {
    return Stack(
      children: [
        Container(
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
                value: article.article,
                onChanged: (value) {
                  setState(() {
                    variantsList.clear();
                    article.variant = null;

                    article.article = value;

                    // Find the selected article in the articles list
                    final selectedArticle = articles.firstWhere(
                      (item) => item.id == value,
                      // orElse: () => null,
                    );
                    log(selectedArticle.toString());
                    // Update the variants list based on the selected article
                    if (selectedArticle.variants != null) {
                      article.variants =
                          selectedArticle.variants.map((variant) {
                        return {
                          'label':
                              "${variant?.family} | ${variant?.taille} | ${variant?.colour} ",
                          'value': variant?.id ?? "",
                        };
                      }).toList();
                    } else {
                      variantsList.clear();
                    }
                  });
                },
                formSubmitted: _formSubmitted,
                items: articlesList,
              ),
              const SizedBox(height: 15),
              buildSelectField(
                label: "Variant",
                hintText: "- Sélectionnez un variant -",
                errorText: "Vous devez entrer un variant ",
                value: article.variant,
                onChanged: (value) {
                  setState(() {
                    article.variant = value;
                  });
                },
                formSubmitted: _formSubmitted,
                items: article
                    .variants, // Use the variants list of the selected article
              ),
              const SizedBox(height: 15),
              buildSelectField(
                label: "Type",
                hintText: "- Sélectionnez un type -",
                errorText: "Vous devez entrer un type",
                value: article.type,
                onChanged: (value) {
                  setState(() {
                    article.type = value;
                  });
                },
                formSubmitted: _formSubmitted,
                items: commandTypesEnum,
              ),
              const SizedBox(height: 15),
              buildInputField(
                label: "Prix",
                hintText: "Entrer le prix d'un seul article",
                errorText: "Vous devez entrer un prix",
                controller: article.prixController,
                formSubmitted: _formSubmitted,
                isNumeric: true,
                isMoney: true,
              ),
              const SizedBox(height: 15),
              buildInputField(
                label: "Nbr d'articles",
                hintText: "Le nombre d'articles",
                errorText: "Vous devez entrer le nombre d'articles",
                controller: article.nbrArticlesController,
                formSubmitted: _formSubmitted,
                isNumeric: true,
              ),
              _imagePickerContainer(article),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 8.0, // Adjust spacing between images
                runSpacing: 8.0, // Adjust spacing between lines
                children: [
                  ...article.files.map(
                    (xFile) => Stack(
                      children: [
                        Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFFECECEC),
                              width: 1,
                            ),
                          ),
                          child: Image.file(
                            File(xFile.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              totalImagesFilesCount--;

                              setState(() {
                                article.files.remove(xFile);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  variants.remove(article);
                });
              },
              icon: const Icon(Icons.close),
              color: Colors.white,
            ),
          ),
        ),
      ],
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

  Widget _imagePickerContainer(ArticleItem articleItem) {
    final int remainingImagesFiles = 5 - totalImagesFilesCount;
    final bool canAddImagesFiles = remainingImagesFiles > 0;

    return canAddImagesFiles
        ? InkWell(
            onTap: () => _selectImage(context, articleItem),
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
          )
        : const SizedBox.shrink(); // Hide the container
  }

  void _selectImage(BuildContext context, ArticleItem articleItem) async {
    if (totalImagesFilesCount >= 5) {
      // Show a message or feedback that the maximum limit is reached
      return;
    }
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final compressedImage = await _compressImage(File(image.path));

      setState(() {
        articleItem.files.add(compressedImage);
      });
      totalImagesFilesCount++;

    }
  }

  Future<XFile> _compressImage(File file) async {
    // Define the target size in bytes (600 KB)
    final int targetSize = 600 * 1024;

    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create a new file in the temporary directory
    final compressedFile = File('${tempDir.path}/image.jpg');

    // Compress the image and save it to the new file
    await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      compressedFile.path,
      minWidth: 1024,
      minHeight: 1024,
      quality: 80,
    );

    // Check if the compressed image is smaller than the target size
    if (await compressedFile.length() < targetSize) {
      // Return the compressed image as an XFile
      return XFile(compressedFile.path);
    } else {
      // If the compressed image is still larger than the target size,
      // reduce the quality and try again
      return _compressImage(compressedFile);
    }
  }
}

class ArticleItem {
  TextEditingController prixController = TextEditingController();
  TextEditingController nbrArticlesController = TextEditingController();
  String? article;
  String? type;
  String? variant;
  List<Map<String, String>> variants = []; // Add this line
  List<XFile> files = [];
}
