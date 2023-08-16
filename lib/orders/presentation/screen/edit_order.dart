import 'dart:developer';
import 'dart:io';

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
import 'package:bts_technologie/mainpage/presentation/controller/account_bloc/account_state.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_bloc.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_event.dart';
import 'package:bts_technologie/orders/presentation/controller/command_bloc/command_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class EditOrderPage extends StatefulWidget {
  final String role;
  final Command command;
  const EditOrderPage({required this.command, required this.role, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController adresssController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController sommePaidController = TextEditingController();
  TextEditingController noteClientController = TextEditingController();

  List<Article> articles = [];
  List<Map<String, String>> articlesList = [];
  List<Map<String, String>> variantsList = [];

  bool _formSubmitted = false;

  String? selectedPage;

  List<ArticleItem> variants = [];
  int count = 1;
  bool isPhotoModified = false;
  int totalImagesFilesCount = 0;

  @override
  void initState() {
    super.initState();
    fullnameController.text = widget.command.nomClient;
    adresssController.text = widget.command.adresse;
    phonenumberController.text = widget.command.phoneNumber.toString();
    sommePaidController.text = widget.command.sommePaid.toString();
    noteClientController.text = widget.command.noteClient ?? "";

    if (widget.role == "pageAdmin") {
      commandTypesEnum = [];
      selectedPage = null;
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
    {"label": "Détail vierge", "value": "Détail vierge"},
    {"label": "Détail personnalisé", "value": "Détail personnalisé"},
    {"label": "Gros vierge", "value": "Gros vierge"},
    {"label": "Gros personnalisé", "value": "Gros personnalisé"},
  ];
  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  bool initList = false;

  void _checkFormValidation(context) {
    bool hasEmptyFields = false;
    bool hasInvalidNumericFields = false;

    if (fullnameController.text.isEmpty ||
        adresssController.text.isEmpty ||
        phonenumberController.text.isEmpty ||
        sommePaidController.text.isEmpty) {
      hasEmptyFields = true;
    }

    if (!isNumeric(sommePaidController.text)) {
      hasEmptyFields = true;
      hasInvalidNumericFields = true;
    }
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
    if (hasEmptyFields || hasInvalidNumericFields) {
      setState(() {
        _formSubmitted = true;
      });
      return;
    }
    setState(() {
      _formSubmitted = true;
    });
    _submitForm(context);
  }

  void _submitForm(context) {
    log("id : ${widget.command.id}");
    CommandModel commandModel;
    if (selectedPage != null) {
      commandModel = CommandModel(
        id: widget.command.id,
        adresse: adresssController.text,
        nomClient: fullnameController.text,
        phoneNumber: int.parse(phonenumberController.text),
        noteClient: noteClientController.text,
        page: selectedPage,
        sommePaid: double.parse(sommePaidController.text),
        articleList: variants.map((variant) {
          if (isPhotoModified == true) {
            return CommandArticle(
                quantity: int.parse(variant.nbrArticlesController.text),
                articleId: variant.article!,
                unityPrice: double.parse(variant.prixController.text),
                commandType: variant.type!,
                variantId: variant.variant!,
                files: variant.files.map((xFile) => File(xFile.path)).toList(),
                photos: variant.cachedNetworkImageUrls,
                deletedPhotos: variant.deletedImages);
          } else {
            return CommandArticle(
                quantity: int.parse(variant.nbrArticlesController.text),
                articleId: variant.article!,
                unityPrice: double.parse(variant.prixController.text),
                commandType: variant.type!,
                variantId: variant.variant!,
                photos: variant.cachedNetworkImageUrls,
                deletedPhotos: variant.deletedImages);
          }
        }).toList(),
      );
    } else {
      commandModel = CommandModel(
        id: widget.command.id,
        adresse: adresssController.text,
        nomClient: fullnameController.text,
        phoneNumber: int.parse(phonenumberController.text),
        noteClient: noteClientController.text,
        sommePaid: double.parse(sommePaidController.text),
        articleList: variants.map((variant) {
          if (isPhotoModified == true) {
            return CommandArticle(
                quantity: int.parse(variant.nbrArticlesController.text),
                articleId: variant.article!,
                unityPrice: double.parse(variant.prixController.text),
                commandType: variant.type!,
                variantId: variant.variant!,
                files: variant.files.map((xFile) => File(xFile.path)).toList(),
                photos: variant.cachedNetworkImageUrls,
                deletedPhotos: variant.deletedImages);
          } else {
            return CommandArticle(
              quantity: int.parse(variant.nbrArticlesController.text),
              articleId: variant.article!,
              unityPrice: double.parse(variant.prixController.text),
              commandType: variant.type!,
              variantId: variant.variant!,
              photos: variant.cachedNetworkImageUrls,
              deletedPhotos: variant.deletedImages,
            );
          }
        }).toList(),
      );
    }
    // log(commandModel.toJson().toString());

    BlocProvider.of<CommandBloc>(context).add(
      EditCommandEvent(
        command: commandModel,
      ),
    );
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
          create: (context) => sl<AccountBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AccountBloc, AccountState>(
                listener: (context, state) {
                  if (state.getUserInfoState == RequestState.loaded) {
                    if (widget.role == "pageAdmin") {
                      // Retrieve userInfo.pages and userInfo.commandTypes
                      final adminPages = state.getUserInfo!.populatedpages!;
                      final adminCommandTypes =
                          state.getUserInfo!.commandeTypes!;
                      final validCommandTypes = adminCommandTypes
                          .where((type) => type != null)
                          .toList();

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
              BlocListener<CommandBloc, CommandesState>(
                listener: (context, state) {
                  if (state.editCommandState == RequestState.loaded) {
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
                          return const PageAdministratorBaseScreen(
                              initialIndex: 1);
                        }
                      }),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.transparent,
                        content: CustomStyledSnackBar(
                            message: "Modified", success: true),
                      ),
                    );
                  } else if (state.editCommandState == RequestState.error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      content: CustomStyledSnackBar(
                          message: state.editCommandMessage, success: false),
                    ));
                  }
                },
              ),
            ],
            child: Builder(
              builder: (context) {
                return BlocBuilder<ArticleBloc, ArticleState>(
                  builder: (context, state) {
                    if (state.getArticlesState == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      try {
                        if (initList == false) {
                          articles = state.getArticles;
                          articlesList = articles.map((article) {
                            return {
                              'label': article.name ?? "",
                              'value': article.id ?? "",
                            };
                          }).toList();

                          variants =
                              widget.command.articleList.map((commandArticle) {
                            log("before photos");
                            print(commandArticle!.photos);
                            final variant = ArticleItem();

                            variant.article = commandArticle!.articleId;
                            variant.variant = commandArticle.variantId;
                            variant.type = commandArticle.commandType;
                            variant.prixController.text =
                                commandArticle.unityPrice.toString();
                            variant.nbrArticlesController.text =
                                commandArticle.quantity.toString();
                            if (commandArticle.photos != null) {
                              totalImagesFilesCount++;
                              variant.cachedNetworkImageUrls =
                                  commandArticle.photos!.map((photoPath) {
                                return photoPath;
                              }).toList();
                              variant.deletedImages = [];
                            }

                            // Find the selected article in the articles list

                            final selectedArticle = articles.firstWhere(
                              (item) => item.id == variant.article,
                            );

                            // Update the variants list of the selected article
                            if (selectedArticle.variants != null) {
                              variant.variants =
                                  selectedArticle.variants.map((variant) {
                                return {
                                  'label': variant?.family ?? "",
                                  'value': variant?.id ?? "",
                                };
                              }).toList();
                            } else {
                              variant.variants.clear();
                            }

                            return variant;
                          }).toList();

                          articlesList = articles.map((article) {
                            return {
                              'label': article.name ?? "",
                              'value': article.id ?? "",
                            };
                          }).toList();
                          initList = true;
                        }
                      } catch (e) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            if (widget.role == "financier") {
                              return const FinancesBaseScreen(initialIndex: 0);
                            } else if (widget.role == "pageAdmin") {
                              return const AdminPageBaseScreen(initialIndex: 0);
                            } else if (widget.role == "logistics") {
                              return const LogistiquesBaseScreen(
                                  initialIndex: 0);
                            } else {
                              return const PageAdministratorBaseScreen(
                                  initialIndex: 1);
                            }
                          }),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            content: CustomStyledSnackBar(
                                message: "Article Deleted", success: false),
                          ),
                        );
                      }

                      return Scaffold(
                        backgroundColor: Colors.white,
                        appBar: const CustomAppBar(
                            titleText: "Modifier la Commande"),
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
                                    errorText:
                                        "Vous devez entrer un numéro de téléphone",
                                    controller: phonenumberController,
                                    formSubmitted: _formSubmitted,
                                    isNumeric: true,
                                  ),
                                  const SizedBox(height: 15),
                                  buildInputField(
                                    label: "Somme versée",
                                    hintText: "Entrez une somme versée",
                                    errorText:
                                        "Vous devez entrer une somme versée",
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
                                      items: selectedPagesEnum,
                                    ),
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
                                buildWhen: (previous, current) =>
                                    previous.createCommandState !=
                                    current.createCommandState,
                                builder: (context, state) {
                                  if (state.createCommandState ==
                                      RequestState.error) {
                                    return Text(
                                      state.createCommandMessage,
                                      style: const TextStyle(color: Colors.red),
                                    );
                                  }
                                  return Container();
                                }),
                            BlocBuilder<CommandBloc, CommandesState>(
                              builder: (context, state) {
                                if (state.editCommandState ==
                                    RequestState.loading) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.black,
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _checkFormValidation(context);
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
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
                                }
                                // When not in loading state, show the button
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
          );
        },
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
                          'label': variant?.family ?? "",
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
                  ...article.cachedNetworkImageUrls.map(
                    (imageUrl) => Stack(
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
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              log("deleting");
                              article.cachedNetworkImageUrls.remove(imageUrl);
                              setState(() {
                                article.files;
                              });
                              article.deletedImages.add(imageUrl);
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
                              article.files.remove(xFile);
                              setState(() {
                                article.files;
                              });
                              totalImagesFilesCount--;
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
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              setState(() {
                variants.remove(article);
              });
            },
            icon: const Icon(Icons.close),
            color: Colors.black,
          ),
        )
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
      if (isPhotoModified == false) {
        isPhotoModified = true;
      }
      final compressedImage = await _compressImage(File(image.path));

      setState(() {
        articleItem.files.add(compressedImage);
        totalImagesFilesCount++;
      });
    }
  }

  Future<XFile> _compressImage(File file) async {
    final int targetSize = 600 * 1024;

    final tempDir = await getTemporaryDirectory();

    final compressedFile = File('${tempDir.path}/image.jpg');

    await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      compressedFile.path,
      minWidth: 1024,
      minHeight: 1024,
      quality: 80,
    );

    if (await compressedFile.length() < targetSize) {
      return XFile(compressedFile.path);
    } else {
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
  List<Map<String, String>> variants = [];
  List<XFile> files = [];
  List<String> cachedNetworkImageUrls = [];
  List<String> deletedImages = [];
}
