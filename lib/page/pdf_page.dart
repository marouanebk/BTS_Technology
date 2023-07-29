import 'package:bts_technologie/api/pdf_invoice_api.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final pdfApi = PdfInvoiceApi();

  Future<void> createAndOpenPdf() async {
    final File? pdfFile =
        await pdfApi.generate(/* pass your Invoice object here */);

    // final pdf = pw.Document();
    // pdf.addPage(
    //   pw.Page(
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Column(
    //         children: [
    //           buildHeader(),
    //           pw.SizedBox(height: 2),
    //           // Small container in the middle
    //           buildFactureNumber(),
    //           buildRens(),
    //           buildTable(),
    //           buildFooter(),
    //           pw.Container(
    //             child: pw.Column(
    //               crossAxisAlignment: pw.CrossAxisAlignment.start,
    //               children: [
    //                 pw.Text(
    //                   'Arreter la presente facture a la somme de:',
    //                   style: pw.TextStyle(
    //                       fontSize: 18, fontWeight: pw.FontWeight.bold),
    //                 ),
    //                 pw.Text(
    //                   'quarante six middle trois sent cisnquate Dinars',
    //                   style: pw.TextStyle(fontSize: 18),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // final output = await getTemporaryDirectory();
    // final pdfPath = "${output.path}/example.pdf";
    // final file = File(pdfPath);
    // final result = await file.writeAsBytes(await pdf.save());
    // if (file.path != null) {
    //   print("printing opening PDF file");
    //   await OpenFile.open(result.path);
    // } else {
    //   print("null PDF file");
    // }
  }

  pw.Widget buildHeader() {
    return pw.Container(
      // width: 1 * PdfPageFormat.cm,
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(10),
        border: pw.Border.all(color: PdfColors.black, width: 2),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'SARL BTS TECHNOLOGIES',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Container(
            height: 2,
            width: 150,
            color: PdfColors.black,
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            children: [
              // Company logo (you can replace this with your logo image)
              pw.Container(
                width: 60,
                height: 60,
                color: PdfColors.grey,
                child: pw.Center(
                  child: pw.Text(
                    'Logo',
                    style: pw.TextStyle(color: PdfColors.white),
                  ),
                ),
              ),
              pw.SizedBox(width: 16),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('N RC', '1234567890'),
                    buildDataRow('N IF', '0987654321'),
                    buildDataRow('N tel', '0123456789'),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildDataRow('Adress', 'Your Address'),
                    buildDataRow('N Art', '9876543210'),
                    buildDataRow('N RIB', '0123456789'),
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
          padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(5),
            border: pw.Border.all(color: PdfColors.black, width: 1),
          ),
          child: pw.Text('Facture N : 190 / 2023'),
        ),
        pw.SizedBox(width: 16),
        pw.Text('Le : 26/07/2023'),
      ],
    );
  }

  pw.Widget buildRens() {
    return pw.Container(
      padding: pw.EdgeInsets.all(16),
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
                    buildDataRow('Client', 'Mohamed Farch'),
                    buildDataRow('RC', ''),
                    buildDataRow('M AO', ''),
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
              pw.Container(padding: pw.EdgeInsets.all(5), child: pw.Text('N')),
              pw.Container(
                  padding: pw.EdgeInsets.all(5), child: pw.Text('Reference')),
              pw.Container(
                  padding: pw.EdgeInsets.all(5), child: pw.Text('Designation')),
              pw.Container(padding: pw.EdgeInsets.all(5), child: pw.Text('U')),
              pw.Container(
                  padding: pw.EdgeInsets.all(5), child: pw.Text('Qte')),
              pw.Container(
                  padding: pw.EdgeInsets.all(5), child: pw.Text('Puv')),
              pw.Container(
                  padding: pw.EdgeInsets.all(5), child: pw.Text('TVA')),
              pw.Container(
                  padding: pw.EdgeInsets.all(5), child: pw.Text('Montant')),
            ],
          ),
          // Table data
          for (int i = 1; i <= 12; i++)
            pw.TableRow(
              children: [
                pw.Container(
                    padding: pw.EdgeInsets.all(5), child: pw.Text('$i')),
                pw.Container(
                    padding: pw.EdgeInsets.all(5), child: pw.Text('P00170')),
                pw.Container(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Text('Tshirt Oversiez Noir M')),
                pw.Container(
                    padding: pw.EdgeInsets.all(5), child: pw.Text('1')),
                pw.Container(
                    padding: pw.EdgeInsets.all(5), child: pw.Text('1')),
                pw.Container(
                    padding: pw.EdgeInsets.all(5), child: pw.Text('850.00')),
                pw.Container(
                    padding: pw.EdgeInsets.all(5), child: pw.Text('0.00')),
                pw.Container(
                    padding: pw.EdgeInsets.all(5), child: pw.Text('850.00')),
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
          padding: pw.EdgeInsets.all(16),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Page"),
      ),
      body: Center(
        child: ElevatedButton(
          // onPressed: () => PdfInvoiceApi.generate(),
          onPressed: createAndOpenPdf,
          child: Text('Open PDF'),
        ),
      ),
    );
  }
}
