import 'package:flutter/material.dart';

class NewFactorPage extends StatefulWidget {
  const NewFactorPage({super.key});

  @override
  State<NewFactorPage> createState() => _NewFactorPageState();
}

class _NewFactorPageState extends State<NewFactorPage> {
  String? nomClient = '';
  String? rc = '';
  String? nis = '';
  String? nif = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Align the title to the center

        title: const Text(
          "Générer une facture ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // backgroundColor:
        //     Colors.blue.withOpacity(0.3), //You can make this transparent
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topContainer(),
                const SizedBox(height: 30),
                _buildInputField(
                  label: "Nom du client",
                  hintText: "Entrez le nom complet du client",
                  value: nomClient,
                  onChanged: (value) {
                    setState(() {
                      nomClient = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                _buildInputField(
                  label: "R.C",
                  hintText: "Numéro de registre de commerce",
                  value: rc,
                  onChanged: (value) {
                    setState(() {
                      rc = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                _buildInputField(
                  label: "NIS",
                  hintText: "Numéro d'identifiant statistique",
                  value: nis,
                  onChanged: (value) {
                    setState(() {
                      nis = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                _buildInputField(
                  label: "NIF",
                  hintText: "Numéro d'identifiant fiscale",
                  value: nif,
                  onChanged: (value) {
                    setState(() {
                      nif = value;
                    });
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50, // Set the height to 50
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (_) => const NewFactorPage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    "Enregistrer la commande",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topContainer() {
    return Container(
      width: double.infinity,
      height: 364,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 0),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 24, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Com N° 18796",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              width: double.infinity, // To take full width
              child: Divider(
                height: 1, // The thickness of the line (1px)
                thickness: 1, // The thickness of the line (1px)
                color: Color(
                    0xFFECECEC), // The color of the line (var(--highlight-grey, #ECECEC))
              ),
            ),
            const Text(
              "2 x Tshirt",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Personnalisé détail | rouge | XL",
              style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "3 x Sweat oversize",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Personnalisé détail | rouge | XL",
              style: TextStyle(
                  color: Color(0xFF9F9F9F),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              width: double.infinity, // To take full width
              child: Divider(
                height: 1, // The thickness of the line (1px)
                thickness: 1, // The thickness of the line (1px)
                color: Color(
                    0xFFECECEC), // The color of the line (var(--highlight-grey, #ECECEC))
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.location_on,
                        size: 16,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'Kalitous, Alger',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9F9F9F),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.phone,
                        size: 16,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: '0783 98 78 67',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9F9F9F),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.attach_money_rounded,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: '3 x 1200DA',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9F9F9F),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(
                          0xFFECECEC), // You can also use Colors.grey[200]
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/tshirt_2.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(
                          0xFFECECEC), // You can also use Colors.grey[200]
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/tshirt_1.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    String? label,
    String? hintText,
    String? value,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9F9F9F)),
        ),
        const SizedBox(height: 4), // Smaller gap here
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9F9F9F)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8), // Smaller padding here
            border: const UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 2), // Smaller gap here
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //     errorText!,
        //     style: const TextStyle(color: Colors.red),
        //     textAlign: TextAlign.right,
        //   ),
        // ),
      ],
    );
  }
}
