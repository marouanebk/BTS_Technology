import 'package:bts_technologie/admin/presentation/screen/base_screen.dart';
import 'package:bts_technologie/facture/page/pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authentification/presentation/screen/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Invoice';

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      // home: const PdfPage(),
      // home: const LoginPage()
            home: const BaseScreen()

    );
  }
}

