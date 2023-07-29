import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:bts_technologie/api/pdf_api.dart';
import 'package:bts_technologie/model/customer.dart';
import 'package:bts_technologie/model/invoice.dart';
import 'package:bts_technologie/model/supplier.dart';
import 'package:bts_technologie/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PdfInvoiceApi {
  Future<File?> generate() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(children: [
          buildHeader(),
          pw.SizedBox(height: 2),
          // Small container in the middle
          buildFactureNumber(),
          buildRens(),
          buildTable(),
          buildFooter(),
          pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Arreter la presente facture a la somme de:',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  'quarante six middle trois sent cisnquate Dinars',
                  style: pw.TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ]

            // SizedBox(height: 3 * PdfPageFormat.cm),
            // buildTitle(invoice),
            // buildInvoice(invoice),
            // Divider(),
            // buildTotal(invoice),
            ),
        // footer: (context) => buildFooter(invoice),
      ),
    );

     final output = await getTemporaryDirectory();
    final pdfPath = "${output.path}/example.pdf";
    final file = File(pdfPath);
    final result = await file.writeAsBytes(await pdf.save());
    if (file.path != null) {
      print("printing opening PDF file");
      await OpenFile.open(result.path);
    } else {
      print("null PDF file");
    }
    // // return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

////////////////////////
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

//   static Widget buildHeader(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 1 * PdfPageFormat.cm),
// // pw.Text('Hello World', style: TextStyle(font: font));
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     buildSupplierAddress(invoice.supplier),
//           //     Container(
//           //       height: 50,
//           //       width: 50,
//           //       // child: BarcodeWidget(
//           //       //   barcode: Barcode.qrCode(),
//           //       //   data: invoice.info.number,
//           //       // ),
//           //     ),
//           //   ],
//           // ),
//           // SizedBox(height: 1 * PdfPageFormat.cm),
//           // Row(
//           //   crossAxisAlignment: CrossAxisAlignment.end,
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     buildCustomerAddress(invoice.customer),
//           //     buildInvoiceInfo(invoice.info),
//           //   ],
//           // ),
//         ],
//       );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'Date',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.description,
        Utils.formatDate(item.date),
        '${item.quantity}',
        '\$ ${item.unitPrice}',
        '${item.vat} %',
        '\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'Vat ${vatPercent * 100} %',
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // static Widget buildFooter(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Divider(),
  //         SizedBox(height: 2 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Address', value: invoice.supplier.address),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
  //       ],
  //     );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
