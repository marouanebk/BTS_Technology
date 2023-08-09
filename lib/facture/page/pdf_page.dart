import 'package:bts_technologie/facture/api/pdf_invoice_api.dart';
import 'package:flutter/material.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final pdfApi = PdfInvoiceApi();

  Future<void> createAndOpenPdf() async {
    // final File? pdfFile =
        // await pdfApi.generate(/* pass your Invoice object here */);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Page"),
      ),
      body: Center(
        child: ElevatedButton(
          // onPressed: () => PdfInvoiceApi.generate(),
          onPressed: createAndOpenPdf,
          child: const Text('Open PDF'),
        ),
      ),
    );
  }
}
