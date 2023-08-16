import 'dart:developer';

import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/mainpage/presentation/components/snackbar.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:bts_technologie/orders/presentation/components/image_detail_page.dart';
import 'package:bts_technologie/orders/presentation/screen/commandes.dart';
import 'package:bts_technologie/orders/presentation/screen/edit_order.dart';
import 'package:bts_technologie/orders/presentation/screen/new_factor.dart';
import 'package:bts_technologie/orders/presentation/screen/prix_soutraitance.dart';
import 'package:bts_technologie/orders/presentation/screen/select_livreur.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactorCommandContainer extends StatefulWidget {
  final Command command;
  final String role;
  const FactorCommandContainer(
      {required this.command, required this.role, super.key});

  @override
  State<FactorCommandContainer> createState() => _FactorCommandContainerState();
}

class _FactorCommandContainerState extends State<FactorCommandContainer> {
  String? type;
  @override
  void initState() {
    super.initState();
    type = widget.command.status;
    log(widget.command.toString());
    // type = "Pas confirmé";
  }

  List<Map<String, String>> statusListAdminstrator = [
    {'label': 'Téléphone éteint', "value": "Téléphone éteint"},
    {'label': 'Numero erroné', "value": "Numero erroné"},
    {'label': 'Annulé', "value": "Annulé"},
    {'label': 'Pas confirmé', "value": "Pas confirmé"},
    {'label': 'Préparé', "value": "Préparé"},
    {'label': 'Expidié', "value": "Expidié"},
    {'label': 'Encaisse', "value": "Encaisse"},
    {'label': 'Retourné', "value": "Retourné"},
  ];

  List<Map<String, String>> modificationsRights = [
    {'label': 'Téléphone éteint', "value": "Téléphone éteint"},
    {'label': 'Numero erroné', "value": "Numero erroné"},
    {'label': 'Annulé', "value": "Annulé"},
    {'label': 'Pas confirmé', "value": "Pas confirmé"},
  ];

  List<Map<String, String>> statusListPageAdmin = [
    {'label': 'Téléphone éteint', "value": "Téléphone éteint"},
    {'label': 'Numero erroné', "value": "Numero erroné"},
    {'label': 'Annulé', "value": "Annulé"},
    {'label': 'Pas confirmé', "value": "Pas confirmé"},
    {'label': 'Préparé', "value": "Préparé"},
  ];

  List<Map<String, String>> statusListLogistriques = [
    {'label': 'Téléphone éteint', "value": "Téléphone éteint"},
    {'label': 'Numero erroné', "value": "Numero erroné"},
    {'label': 'Annulé', "value": "Annulé"},
    {'label': 'Pas confirmé', "value": "Pas confirmé"},
    {'label': 'Préparé', "value": "Préparé"},
    {'label': 'Expidié', "value": "Expidié"},
    {'label': 'Encaisse', "value": "Encaisse"},
    {'label': 'Retourné', "value": "Retourné"},
  ];

  List<Map<String, String>> statusListFinancier = [
    {'label': 'Expidié', "value": "Expidié"},
    {'label': 'Encaisse', "value": "Encaisse"},
    {'label': 'Retourné', "value": "Retourné"},
  ];

  List<Map<String, String>> getStatusListBasedOnRole() {
    switch (widget.role) {
      case 'admin':
        return statusListAdminstrator;
      case 'pageAdmin':
        return statusListPageAdmin;
      case 'logistics':
        return statusListLogistriques;
      case 'financier':
        return statusListFinancier;
      default:
        return [];
    }
  }

  bool _containsStatus(List<Map<String, String>> statusList, String? status) {
    return statusList.any((map) => map['value'] == status);
  }

  Future<void> _updateStatus(String? newStatus, context) async {
    if (newStatus == "Expidié") {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (_) => SelectLivreur(
            id: widget.command.id!,
            role: widget.role,
          ),
        ),
      );
    } else {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        final response = await Dio().patch(
          ApiConstance.updateCommandStatus(
              widget.command.id!), // Replace with your API URL
          data: {'status': newStatus},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return OrdersPage(role: widget.role);
              // if (widget.role == "financier") {
              //   return const FinancesBaseScreen(initialIndex: 0);
              // } else if (widget.role == "pageAdmin") {
              //   return const AdminPageBaseScreen(initialIndex: 0);
              // } else if (widget.role == "logistics") {
              //   return const LogistiquesBaseScreen(initialIndex: 0);
              // } else {
              //   return const PageAdministratorBaseScreen(initialIndex: 1);
              // }
            }),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              content: CustomStyledSnackBar(
                  message: "Status Modifier", success: true),
            ),
          );
        } else {
          SnackBar(
            backgroundColor: Colors.transparent,
            content: CustomStyledSnackBar(
                message: response.data['err'], success: false),
          );
        }
      } catch (error) {
        log('Error updating status: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isModificationAllowed = widget.role == "admin" ||
        widget.role == "financier" ||
        getStatusListBasedOnRole().contains(type);
    bool showModifyButton = false;
    ;

    if (widget.role == "admin" ||
        (widget.role == "pageAdmin" &&
            _containsStatus(modificationsRights, type)) ||
        (widget.role == "logistics" &&
            _containsStatus(modificationsRights, type))) {
      showModifyButton = true;
    }

    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFECECEC),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            for (var item in widget.command.articleList) productDetail(item!),
            const SizedBox(
              width: double.infinity,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFECECEC),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            clientInfo(widget.command, isModificationAllowed),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 8.0, // Adjust spacing between images
              runSpacing: 8.0, // Adjust spacing between lines
              children: [
                ...widget.command.articleList
                    .where((article) => article?.photos != null)
                    .expand((article) => article!.photos!)
                    .map((photoUrl) => InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: ImageDetailPage(imagePath: photoUrl,),
                              withNavBar:
                                  false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );

                            // Navigator.push(
                            //   context,
                            //   _createRoute(photoUrl),
                            // );
                          },
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
                            child: Image.network(
                              photoUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Icon(Icons
                                    .error); // You can display an error icon here if loading fails
                              },
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            if (isModificationAllowed) ...[
              containerButton(
                  "Ajouter un prix de sous traitance",
                  PrixSoutraitancePage(
                    id: widget.command.id!,
                    role: widget.role,
                    // command: widget.command,
                  )),
              const SizedBox(
                height: 10,
              ),
            ],

            if (showModifyButton)
              containerButton(
                  "Modifier la commande",
                  EditOrderPage(
                    role: widget.role,
                    command: widget.command,
                  )),
            const SizedBox(
              height: 10,
            ),
            //add the generate factor
            if (widget.role == 'admin' || widget.role == 'logistics')
              containerButton(
                  "Générer une facture",
                  NewFactorPage(
                    command: widget.command,
                  )),
            const SizedBox(
              height: 10,
            ),
            confirmationContainer(
              value: type,
              onChanged: (value) {
                setState(() {
                  _updateStatus(value, context);

                  type = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Saisie par @${widget.command.user}",
                style: const TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.command.livreur != null)
              Center(
                child: Text(
                  "Livré par ${widget.command.livreur}",
                  style: const TextStyle(
                    color: Color(0xFF9F9F9F),
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget clientInfo(Command command, isModificationAllowed) {
    int totalPrice = command.articleList.fold(0, (sum, article) {
      return sum + (article!.quantity * article.unityPrice.toInt());
    });

    String totalPriceMessage = command.sommePaid == 0
        ? totalPrice.toString()
        : "$totalPrice - ${command.sommePaid.toString()}  DA";

    String st;
    if (command.prixSoutraitant == null) {
      st = "non définie";
    } else {
      st = command.prixSoutraitant.toString();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.location_on,
                    size: 16,
                  ),
                ),
              ),
              TextSpan(
                text: command.adresse,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9F9F9F),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.phone,
                    size: 16,
                  ),
                ),
              ),
              TextSpan(
                text: command.phoneNumber.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9F9F9F),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
              TextSpan(
                text: totalPriceMessage,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9F9F9F),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        if (command.noteClient != null)
          Row(
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.event_note,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: command.noteClient,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9F9F9F),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

        // Prix Soutraitant
        if (isModificationAllowed) ...[
          RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      // Icons.event_note,
                      Icons.numbers,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                ),
                TextSpan(
                  text: st,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9F9F9F),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget productDetail(CommandArticle command) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${command.quantity} x ${command.articleName}",
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${command.commandType} | ${command.colour} | ${command.taille} | ${command.family} ",
          style: const TextStyle(
              color: Color(0xFF9F9F9F),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget confirmationContainer(
      {required String? value, required void Function(String?) onChanged}) {
    List<Map<String, String>> statusList = getStatusListBasedOnRole();

    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 50, // Set the height to 50
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(
                0xFF111111), // Replace with your desired border color
            width: 1,
          ),
        ),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              // add this line
              alignedDropdown: true, // add this line
              child: DropdownButton<String>(
                value: value,
                onChanged: onChanged,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                dropdownColor: Colors.black,
                iconEnabledColor: Colors.white,
                iconSize: 30,
                icon: const Icon(Icons.arrow_drop_down),
                items: statusList.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item['value'],
                    child: Center(child: Text(item['label']!)),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget containerButton(String title, Widget pushPage) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 50, // Set the height to 50
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(
                0xFF111111), // Replace with your desired border color
            width: 1,
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (_) => pushPage,
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown, // Scale down the text if needed
            alignment: Alignment.center,

            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute(String imagePath) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ImageDetailPage(imagePath: imagePath);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
