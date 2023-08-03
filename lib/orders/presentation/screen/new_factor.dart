import 'package:bts_technologie/admin/presentation/components/factor_container.dart';
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
                factorContainer(),
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
