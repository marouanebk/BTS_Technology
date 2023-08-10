import 'package:bts_technologie/authentication/presentation/screen/login_page.dart';
import 'package:bts_technologie/base_screens/admin_base_screen.dart';
import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/finances_base_screen.dart';
import 'package:bts_technologie/base_screens/logistics_base_screen.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/facture/page/pdf_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/params_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainpage/presentation/screen/account manager/account_manager.dart';

int? isLoggedIn;
String? type;
void main() async {
  Logger.root.level = Level.WARNING; // Change the log level as needed

  Logger.root.onRecord.listen((record) {});
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await ServiceLocator().init();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isLoggedIn = prefs.getInt("is logged in");
  type = prefs.getString("type");

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
      initialRoute: (isLoggedIn == 1)
          ? ((type == "admin")
              ? '/pageAdministrator'
              : ((type == "PageAdministratorBaseScreen")
                  ? '/finances'
                  : ((type == "pageAdmin")
                      ? '/adminPage'
                      : ((type == "logistics") ? '/logistiques' : '/'))))
          : '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/pageAdministrator': (context) => const PageAdministratorBaseScreen(),
        '/adminPage': (context) => const AdminPageBaseScreen(),
        '/logistiques': (context) => const LogistiquesBaseScreen(),
        '/finances': (context) => const FinancesBaseScreen(),
        '/accountManager': (context) => const AccountManager(),
        '/adminParams': (context) => const AdminParams(),
        '/createPage': (context) => const NewPageAccount(),
      },

      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const LoginPage(),
      //   '/pageAdministrator': (context) => const PageAdministratorBaseScreen(),
      //   '/adminPage': (context) => const AdminPageBaseScreen(),
      //   '/logistiques': (context) => const LogistiquesBaseScreen(),
      //   '/finances': (context) => const FinancesBaseScreen(),
      // },
      // home: (isLoggedIn == 1)
      //     ? ((type == "admin")
      //         ? const PageAdministratorBaseScreen()
      //         : ((type == "PageAdministratorBaseScreen")
      //             ? const FinancesBaseScreen()
      //             : ((type == "pageAdmin")
      //                 ? const AdminPageBaseScreen()
      //                 : ((type == "logistics")
      //                     ? const LogistiquesBaseScreen()
      //                     : const LoginPage()))))
      //     : const LoginPage(),
    );
  }
}
