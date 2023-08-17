import 'dart:developer';

import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/authentication/presentation/screen/login_page.dart';
import 'package:bts_technologie/base_screens/admin_base_screen.dart';
import 'package:bts_technologie/base_screens/administrator_base_screen.dart';
import 'package:bts_technologie/base_screens/finances_base_screen.dart';
import 'package:bts_technologie/base_screens/logistics_base_screen.dart';
import 'package:bts_technologie/core/services/service_locator.dart';
import 'package:bts_technologie/mainpage/domaine/Entities/page_entity.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/edit_user_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_livreur_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_user_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/company_informations.dart';
import 'package:bts_technologie/mainpage/presentation/screen/excel.dart';
import 'package:bts_technologie/mainpage/presentation/screen/params_admin.dart';
import 'package:bts_technologie/push_notificaitons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainpage/presentation/screen/account manager/account_manager.dart';

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

int? isLoggedIn;
String? type;
void main() async {
  Logger.root.level = Level.WARNING; // Change the log level as needed

  Logger.root.onRecord.listen((record) {});
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getToken().then((value) => log("token $value"));
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    log("on Message Opened $message");
    Navigator.pushNamed(navigatorkey.currentState!.context, '/push-page',
        arguments: ["message", "(message.data)"]);
  });

  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) async {
      log("on Message Opened $message");
      Navigator.pushNamed(navigatorkey.currentState!.context, '/push-page',
          arguments: ["message", "(message.data)"]);
    },
  );

  FirebaseMessaging.instance.getInitialMessage().then(
    (RemoteMessage? message) {
      if (message != null) {
        log("on Message Opened $message");
        Navigator.pushNamed(navigatorkey.currentState!.context, '/push-page',
            arguments: ["message", "(message.data)"]);
      }
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("background message handler $message");
}

class MyApp extends StatelessWidget {
  static const String title = 'Invoice';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorkey,
      title: title,
      theme: ThemeData(
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.transparent,
          contentTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.0,
          ),
        ),
      ),
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
        '/push-page': (context) => const PushNotifications(),
        '/pageAdministrator': (context) => const PageAdministratorBaseScreen(),
        '/adminPage': (context) => const AdminPageBaseScreen(),
        '/logistiques': (context) => const LogistiquesBaseScreen(),
        '/finances': (context) => const FinancesBaseScreen(),
        '/accountManager': (context) => const AccountManager(),
        '/adminParams': (context) => const AdminParams(),
        '/excelFiles': (context) => const ExcelFiles(),
        '/companyInformations': (context) => const CompanyInformations(),
        '/createPage': (context) => const NewPageAccount(),
        '/createLivreur': (context) => const NewLivreurAccount(),
        '/createUser': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          List<FacePage> pages = args['pages'];
          return NewUserPage(pages: pages);
        },
        '/editUser': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          User user = args['user'];
          List<FacePage> pages = args['pages'];
          return EditUserPage(user: user, pages: pages);
        },
      },
    );
  }
}
