import 'dart:io';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

class PdfInvoiceApi {
  Future<File?> generate() async {
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
              buildHeader(image),
              pw.SizedBox(height: 2),
              // Small container in the middle
              buildFactureNumber(),
              buildRens(),
              pw.SizedBox(height: 8),

              buildTable(),
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
            ]),
      ),
    );

    final output = await getTemporaryDirectory();
    final pdfPath = "${output.path}/example.pdf";
    final file = File(pdfPath);
    final result = await file.writeAsBytes(await pdf.save());
    // ignore: unnecessary_null_comparison
    if (file.path != null) {
      log("printing opening PDF file");
      await OpenFile.open(result.path);
    } else {
      log("null PDF file");
    }
    return null;
    // // return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  pw.Widget buildHeader(image) {
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
                padding: EdgeInsets.only(right: 20),
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
                    buildDataRow('N° RC : ', '1234567890'),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° IF : ', '0987654321'),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° tel : ', '0123456789'),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('Adress : ', 'Your Address'),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° Art : ', '9876543210'),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° RIB : ', '0123456789'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget buildFactureNumber() {
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
                '190 / 2023',
                style: pw.TextStyle(
                    fontWeight:
                        pw.FontWeight.normal), // Make the number not bold
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 16),
        pw.Text(
          'Le : 26/07/2023',
          style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal), // Make the date not bold
        ),
      ],
    );
  }

  pw.Widget buildRens() {
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
                    buildDataRow('Client :', 'Mohamed Farch'),
                    pw.SizedBox(height: 7),
                    buildDataRow('R.C :', ''),
                    pw.SizedBox(height: 7),
                    buildDataRow('N° AI : ', ''),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('Adress', 'El Oued'),
                    buildDataRow('NIS', ''),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('NIF', ''),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget buildTable() {
    return pw.Container(
      child: pw.Table(
        border: pw.TableBorder.all(width: 1, color: PdfColors.black),
        children: [
          // Table header
          pw.TableRow(
            children: [
              pw.Container(
                  padding: const pw.EdgeInsets.all(5), child: pw.Text('N')),
              pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('Reference')),
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
          for (int i = 1; i <= 12; i++)
            pw.TableRow(
              children: [
                pw.Container(
                    padding: const pw.EdgeInsets.all(5), child: pw.Text('$i')),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text('P00170')),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text('Tshirt Oversiez Noir M')),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5), child: pw.Text('1')),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5), child: pw.Text('1')),
                pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text('850.00')),
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
