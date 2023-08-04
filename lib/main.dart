import 'dart:developer';

import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/admin_base_screen.dart';
import 'package:bts_technologie/base_screens/logistics_base_screen.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/facture/page/pdf_page.dart';
import 'package:bts_technologie/logistiques/presentation/screen/logistiques.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authentication/presentation/screen/login_page.dart';

void main() async {
  await ServiceLocator().init();

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
        home: const LogistiquesBaseScreen()
        // home: const BaseScreen()
        // home: const AdminPageBaseScreen(),

        );
  }
}
