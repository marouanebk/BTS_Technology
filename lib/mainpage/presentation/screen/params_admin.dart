import 'package:bts_technologie/mainpage/presentation/components/custom_app_bar.dart';
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
      appBar: const CustomAppBar(titleText: "Paramètres d'admin"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            adminParamsContainer("Gestionnaire des compte",
                "assets/images/compte.svg", "/accountManager"),
            const SizedBox(
              height: 10,
            ),
            adminParamsContainer("Téléchargeement Excel",
                "assets/images/excel.svg", "/excelFiles"),
            const SizedBox(
              height: 10,
            ),
            adminParamsContainer("Informations de l'entreprise",
                "assets/images/entreprise.svg", "/companyInformations"),
          ],
        ),
      ),
    );
  }

  Widget adminParamsContainer(String text, String link, String route) {
    return InkWell(
      onTap: () {
        // Navigator.of(context, rootNavigator: true).push(
        //   MaterialPageRoute(
        //     builder: (_) => page,
        //   ),
        // );
        Navigator.of(context, rootNavigator: true).pushNamed(route);
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
