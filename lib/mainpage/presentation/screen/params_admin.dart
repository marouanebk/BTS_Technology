import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/account_manager.dart';
import 'package:bts_technologie/mainpage/presentation/screen/company_informations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminParams extends StatefulWidget {
  const AdminParams({super.key});

  @override
  State<AdminParams> createState() => _AdminParamsState();
}

class _AdminParamsState extends State<AdminParams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Align the title to the center

        title: const Text(
          "Paramètres d'admin",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),

        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            // adminParamsContainer("Gestionnaire des compte",
            //     "assets/images/compte.svg", const AccountManager()),

            ///////////////////////////////

            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/accountManager');
                // Navigator.of(context, rootNavigator: true).push(
                //   MaterialPageRoute(
                //     builder: (_) => page,
                //   ),
                // );
              },
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
                      "assets/images/compte.svg",
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      "Gestionnaire des compte",
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.0,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /////////////////////////
            const SizedBox(
              height: 10,
            ),
            adminParamsContainer("Téléchargeement Excel",
                "assets/images/excel.svg", const CompanyInformations()),
            const SizedBox(
              height: 10,
            ),
            adminParamsContainer("Informations de l'entreprise",
                "assets/images/entreprise.svg", const CompanyInformations()),
          ],
        ),
      ),
    );
  }

  Widget adminParamsContainer(String text, String link, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },
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
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                height: 1.0,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
