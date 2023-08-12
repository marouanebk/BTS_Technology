import 'dart:developer';
import 'dart:io';

import 'package:bts_technologie/authentication/data/models/user_model.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:bts_technologie/finances/data/model/finance_model.dart';
import 'package:bts_technologie/logistiques/data/model/article_model.dart';
import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
import 'package:bts_technologie/orders/data/Models/command_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

//Local imports
// import 'helper/save_file_mobile.dart';

class ExcelFiles extends StatefulWidget {
  const ExcelFiles({super.key});

  @override
  State<ExcelFiles> createState() => _ExcelFilesState();
}

class _ExcelFilesState extends State<ExcelFiles> {
  @override
  void initState() {
    initCommandData();
    initFinanceData();
    initArticlesData();
    super.initState();
  }

  List<CommandModel> commands = [];
  List<FinanceModel> finances = [];
  List<ArticleModel> articles = [];
  Future<void> initCommandData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await Dio().get(
      ApiConstance.getCommandsExcel,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      // log(response.data.toString());
      commands = List<CommandModel>.from((response.data as List).map(
        (e) => CommandModel.fromJson(e),
      ));

      setState(() {
        commands;
      });
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['error']));
    }
  }

  Future<void> initArticlesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await Dio().get(
      ApiConstance.getLogsExcel,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      // log(response.data.toString());
      articles = List<ArticleModel>.from((response.data as List).map(
        (e) => ArticleModel.fromJson(e),
      ));

      setState(() {
        articles;
      });
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['error']));
    }
  }

  Future<void> initFinanceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getFinancesApi,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      // finances = List<FinanceModel>.from((response.data as List).map(
      //   (e) => FinanceModel.fromJson(e),
      // ));
      finances = FinanceModel.fromJsonList(response.data);
      setState(() {
        finances;
      });
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['err']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(titleText: "Téléchargeement Excel"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            adminParamsContainer(
                "Télécharger les données des commandes",
                "assets/images/navbar/commandes_activated.svg",
                "/accountManager",
                generateCommandsExcel),
            const SizedBox(
              height: 10,
            ),
            adminParamsContainer(
                "Télécharger les données du logistique",
                "assets/images/navbar/logis_activated.svg",
                "/excelFiles",
                generateLogisticsExcel),
            const SizedBox(
              height: 10,
            ),
            adminParamsContainer(
                "Télécharger les données des finances",
                "assets/images/navbar/finances_activated.svg",
                "/companyInformations",
                generateFinanceExcel),
          ],
        ),
      ),
    );
  }

  Widget adminParamsContainer(
    String text,
    String link,
    String route,
    Future<void> Function() initFunction,
  ) {
    return InkWell(
      onTap: initFunction,

      // onTap: () {
      //   generateExcel();

      //   // Navigator.of(context, rootNavigator: true).pushNamed(route);
      // },
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFFFFFFF),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              offset: Offset(0, 0),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              link,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                text,
                softWrap: true,
                maxLines: null,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: Colors.black,
                  height: 1.0,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> generateCommandsExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
        sheet.getRangeByName('A1').columnWidth = 20;
    sheet.getRangeByName('B1').columnWidth = 20;
    sheet.getRangeByName('C1').columnWidth = 20;
    sheet.getRangeByName('D1').columnWidth = 20;
    sheet.getRangeByName('E1').columnWidth = 20;
    sheet.getRangeByName('F1').columnWidth = 20;
    sheet.getRangeByName('G1').columnWidth = 20;
    sheet.getRangeByName('H1').columnWidth = 20;
    sheet.getRangeByName('I1').columnWidth = 20;

    sheet.getRangeByName('J1').columnWidth = 20;
    sheet.getRangeByName('K1').columnWidth = 20;
    sheet.getRangeByName('L1').columnWidth = 20;
    sheet.getRangeByName('M1').columnWidth = 20;
    sheet.getRangeByName('N1').columnWidth = 20;
    sheet.getRangeByName('O1').columnWidth = 20;
    sheet.getRangeByName('P1').columnWidth = 20;
    sheet.getRangeByName('Q1').columnWidth = 20;
    sheet.getRangeByName('R1').columnWidth = 20;

    sheet.getRangeByName('A1').setText('Commande');
    sheet.getRangeByName('B1').setText('Etat');
    sheet.getRangeByName('C1').setText('Nom Client ');
    sheet.getRangeByName('D1').setText('Adress ');
    sheet.getRangeByName('E1').setText('Numero de telephone  ');
    sheet.getRangeByName('F1').setText('Prix Total ');
    sheet.getRangeByName('G1').setText('Somme Verse ');
    sheet.getRangeByName('H1').setText('Prix Soust raitance  ');
    sheet.getRangeByName('I1').setText('note client  ');
    sheet.getRangeByName('J1').setText('Saisi par  ');
    sheet.getRangeByName('K1').setText('Livre avec  ');
    sheet.getRangeByName('L1').setText('Historique de modifications ');
    sheet.getRangeByName('M1').setText('Article ');
    sheet.getRangeByName('N1').setText('Couleur ');
    sheet.getRangeByName('O1').setText('taille ');
    sheet.getRangeByName('P1').setText('famille ');
    sheet.getRangeByName('Q1').setText('type ');
    sheet.getRangeByName('R1').setText('nombre ');

    // ... Add more headers as needed

    // Populate the Excel sheet with command data
    for (var rowIndex = 0; rowIndex < commands.length; rowIndex++) {
      final command = commands[rowIndex];

      sheet
          .getRangeByName('A${rowIndex + 2}')
          .setText(convertDateTime(command.createdAt!) ?? '');
      sheet
          .getRangeByName('B${rowIndex + 2}')
          .setText(command.comNumber.toString());
      sheet
          .getRangeByName('C${rowIndex + 2}')
          .setText(command.noteClient ?? '');
      // ... Populate more columns as needed
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String filename = '$path/Output.xlsx';

    final File file = File(filename);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(filename);
  }

  Future<void> generateLogisticsExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').columnWidth = 20;
    sheet.getRangeByName('B1').columnWidth = 20;
    sheet.getRangeByName('C1').columnWidth = 20;
    sheet.getRangeByName('D1').columnWidth = 20;
    sheet.getRangeByName('E1').columnWidth = 20;
    sheet.getRangeByName('F1').columnWidth = 20;
    sheet.getRangeByName('G1').columnWidth = 20;
    sheet.getRangeByName('H1').columnWidth = 20;
    sheet.getRangeByName('I1').columnWidth = 20;

    sheet.getRangeByName('A1').setText('article');
    sheet.getRangeByName('B1').setText('nombre total ');
    sheet.getRangeByName('C1').setText("prix d'achat");
    sheet.getRangeByName('D1').setText("prix de vente en gros ");
    sheet.getRangeByName('E1').setText("quantity d'alert");
    sheet.getRangeByName('F1').setText("Couleur");
    sheet.getRangeByName('G1').setText("taille");
    sheet.getRangeByName('H1').setText("famille");
    sheet.getRangeByName('I1').setText("nombre");

    for (var rowIndex = 0; rowIndex < articles.length; rowIndex++) {
      final article = articles[rowIndex];
      // int totalQuantity =
      //     article.variants.fold(0, (sum, variant) => sum + variant!.quantity);

      sheet.getRangeByName('A${rowIndex + 2}').setText(article.name!);
      sheet
          .getRangeByName('B${rowIndex + 2}')
          .setText("totalQuantity.toString() \n hello");
      sheet
          .getRangeByName('C${rowIndex + 2}')
          .setText(article.buyingPrice.toString());
      sheet
          .getRangeByName('D${rowIndex + 2}')
          .setText(article.grosPrice.toString());

      sheet
          .getRangeByName('E${rowIndex + 2}')
          .setText(article.alertQuantity.toString());
      String colors = "";
      String taille = "";
      String famille = "";
      String nombre = "";

      for (var variant in article.variants) {
        colors += "\n ${variant!.colour}";
        taille += "\n ${variant.taille}";
        famille += "\n ${variant.family}";
        nombre += "\n ${variant.quantity}";
      }
      sheet.getRangeByName('F${rowIndex + 2}').setText(colors);
      sheet.getRangeByName('G${rowIndex + 2}').setText(taille);
      sheet.getRangeByName('H${rowIndex + 2}').setText(famille);
      sheet.getRangeByName('I${rowIndex + 2}').setText(nombre);

      // ... Populate more columns as needed
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String filename = '$path/Output.xlsx';

    final File file = File(filename);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(filename);
  }

  Future<void> generateFinanceExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').columnWidth = 20;
    sheet.getRangeByName('B1').columnWidth = 20;
    sheet.getRangeByName('C1').columnWidth = 20;

    sheet.getRangeByName('A1').setText('Jour');
    sheet.getRangeByName('B1').setText('gain / perte');
    sheet.getRangeByName('C1').setText('raison ');

    for (var rowIndex = 0; rowIndex < finances.length; rowIndex++) {
      final finance = finances[rowIndex];

      sheet.getRangeByName('A${rowIndex + 2}').setText(finance.date! ?? '');
      sheet
          .getRangeByName('B${rowIndex + 2}')
          .setText(finance.money.toString());
      sheet.getRangeByName('C${rowIndex + 2}').setText(
          finance.money > 0 ? "Com N° ${finance.label}" : finance.label);
      // ... Populate more columns as needed
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String filename = '$path/Output.xlsx';

    final File file = File(filename);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(filename);
  }

  String convertDateTime(String dateTimeString) {
    final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    final outputFormat = DateFormat("dd/MM/yyyy");

    final parsedDateTime = inputFormat.parse(dateTimeString);
    final formattedDateTime = outputFormat.format(parsedDateTime);

    return formattedDateTime;
  }
}
