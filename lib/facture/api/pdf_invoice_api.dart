import 'dart:io';
import 'package:bts_technologie/mainpage/domaine/Entities/entreprise_entity.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

class PdfInvoiceApi {
  Future<File?> generate(Command command, Entreprise? entreprise, String? rc,
      String? nis, String? nif, String? nai) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(
      (await rootBundle.load('assets/images/bts_tech_bg.jpg'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        build: (pw.Context context) => pw.Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(
                image,
                entreprise!,
              ),
              pw.SizedBox(height: 2),
              // Small container in the middle
              buildFactureNumber(command.comNumber!.toInt()),
              buildRens(command, rc, nis, nif, nai),
              pw.SizedBox(height: 8),

              buildTable(command),
              pw.Spacer(),
              buildFooter(),
              pw.Container(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Arreter la presente facture a la somme de:',
                      textAlign: TextAlign.left,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      'quarante six middle trois sent cisnquate Dinars',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 50),
            ]),
      ),
    );

    final output = await getTemporaryDirectory();
    final pdfPath = "${output.path}/facture_N°${command.comNumber}.pdf";
    final file = File(pdfPath);
    final result = await file.writeAsBytes(await pdf.save());
    // ignore: unnecessary_null_comparison
    if (file.path != null) {
      await OpenFile.open(result.path);
    } else {
      log("null PDF file");
    }
    return null;
    // // return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  pw.Widget buildHeader(image, Entreprise entreprise) {
    return pw.Container(
      // width: 1 * PdfPageFormat.cm,
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(10),
        border: pw.Border.all(color: PdfColors.black, width: 2),
      ),
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                  width: 60,
                  height: 60,
                  color: PdfColors.grey,
                  child: pw.Image(image)),
              pw.Padding(
                padding: const EdgeInsets.only(right: 20),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'SARL BTS TECHNOLOGIES',
                      style: pw.TextStyle(
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                        fontStyle:
                            pw.FontStyle.italic, // Make the header text italic
                        // decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.Container(
                        alignment: Alignment.center,
                        width: 250,
                        height: 1,
                        color: PdfColors.black

                        // endIndent: constraints.maxWidth - textSize.width,
                        )
                  ],
                ),
              ),
              pw.Text(""),
            ],
          ),

          pw.SizedBox(height: 8),
          // pw.Container(
          //   height: 2,
          //   width: 150,
          //   color: PdfColors.black,
          // ),
          pw.SizedBox(height: 16),
          pw.Row(
            children: [
              // Company logo (you can replace this with your logo image)

              pw.SizedBox(width: 16),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('N° RC : ', entreprise.numberRC.toString()),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° IF : ', entreprise.numberIF.toString()),
                    pw.SizedBox(height: 7),
                    buildDataRow(
                        'N° tel : ', entreprise.phoneNumber.toString()),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('Adress : ', entreprise.adresse.toString()),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° Art : ', entreprise.numberART.toString()),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° RIB : ', entreprise.numberRIB.toString()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget buildFactureNumber(int number) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(5),
            border: pw.Border.all(
                color: PdfColors.black, width: 2), // Increased border width
          ),
          child: pw.Row(
            // A new row to contain the label and the number together
            mainAxisSize:
                pw.MainAxisSize.min, // Only take the minimum width necessary
            children: [
              pw.Text(
                'Facture N° : ',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold), // Make the label bold
              ),
              pw.Text(
                '$number / 2023',
                style: pw.TextStyle(
                    fontWeight:
                        pw.FontWeight.normal), // Make the number not bold
              ),
            ],
          ),
        ),
        // pw.SizedBox(width: 16),
        pw.Text(
          'Le : Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
          style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal), // Make the date not bold
        ),
      ],
    );
  }

  pw.Widget buildRens(Command command, rc, nis, nif, nai) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(10),
        border: pw.Border.all(color: PdfColors.black, width: 2),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'Renseignement Client',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.Divider(thickness: 2),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('Client :', command.nomClient),
                    pw.SizedBox(height: 7),
                    buildDataRow('R.C :', rc ?? ""),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° AI : ', nai ?? ""),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('Adress : ', command.adresse),
                    pw.SizedBox(height: 7),
                    buildDataRow('NIS : ', nis ?? ""),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('NIF : ', nif ?? ""),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget buildTable(Command command) {
    int index = 0;

    return pw.Container(
      child: pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        children: [
          // Table header
          pw.TableRow(
            children: [
              pw.Container(
                  padding: const pw.EdgeInsets.all(5), child: pw.Text('N')),
              // pw.Container(
              //     padding: const pw.EdgeInsets.all(5),
              //     child: pw.Text('Reference')),
              pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('Designation')),
              pw.Container(
                  padding: const pw.EdgeInsets.all(5), child: pw.Text('U')),
              pw.Container(
                  padding: const pw.EdgeInsets.all(5), child: pw.Text('Qte')),
              pw.Container(
                  padding: const pw.EdgeInsets.all(5), child: pw.Text('Puv')),
              pw.Container(
                  padding: const pw.EdgeInsets.all(5), child: pw.Text('TVA')),
              pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('Montant')),
            ],
          ),
          // Table data
          for (var i = 0; i < command.articleList.length; i++)
            pw.TableRow(
              children: [
                pw.Container(
                    padding: const pw.EdgeInsets.all(5), child: pw.Text('$i')),
                // pw.Container(
                //     padding: const pw.EdgeInsets.all(5),
                //     child: pw.Text('P00170')),
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(command.articleList[i]!.articleName!),
                ),

                pw.Container(
                    padding: const pw.EdgeInsets.all(5), child: pw.Text('1')),
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    command.articleList[i]!.quantity.toString(),
                  ),
                ),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child:
                        pw.Text(command.articleList[i]!.unityPrice.toString())),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text('0.00')),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text('850.00')),
              ],
            ),
        ],
      ),
    );
  }

  pw.Widget buildFooter() {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Text('Mode paiement: Espece'),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(10),
            border: pw.Border.all(color: PdfColors.black, width: 2),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              buildDataRow('Montant HT', '46350'),
              buildDataRow('Montant TVA', ''),
              buildDataRow('Montant TTC', '463500'),
              buildDataRow('Timbre', '0'),
              buildDataRow('Montant Net a payer', '436500'),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget buildDataRow(String title, String value) {
    return pw.Row(
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(width: 8),
        pw.Text(value),
      ],
    );
  }
}
