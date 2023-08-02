import 'package:bts_technologie/admin/presentation/screen/new/new_factor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewArticle extends StatefulWidget {
  @override
  _NewArticleState createState() => _NewArticleState();
}

class _NewArticleState extends State<NewArticle> {
  String? nomArticle = '';
  String? unite = '';
  String? prixAchat = '';
  String? prixGros = '';
  String? quanAlert = '';
  String? selectedType = '';
  String? selectedColor = '';
  String? selectedSize = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Align the title to the center

        title: const Text(
          "Ajouter un article",
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
            padding: const EdgeInsets.only(right: 20.0, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Nom de l'article",
                  hintText: "Entrez le nom de l'article",
                  errorText: "Vous devez entrer une nom",
                  value: nomArticle,
                  onChanged: (value) {
                    setState(() {
                      nomArticle = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Unité",
                  hintText: "Entrez l'unité",
                  errorText: "Vous devez entrer une Unité",
                  value: unite,
                  onChanged: (value) {
                    setState(() {
                      unite = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Prix d'achat",
                  hintText: "Entrez le prix d'achat",
                  errorText: "Vous devez entrer le prix d'achat",
                  value: prixAchat,
                  onChanged: (value) {
                    setState(() {
                      prixAchat = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Prix de ventre en gros",
                  hintText: "Entrez le prix de vente en gros",
                  errorText: "Vous devez entrer le prix de vente en gros",
                  value: prixGros,
                  onChanged: (value) {
                    setState(() {
                      prixGros = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  label: "Quantité d'alerte",
                  hintText: "Entrez la quantité d'alerte",
                  errorText: "Vous devez entrer la quantité d'alerte",
                  value: quanAlert,
                  onChanged: (value) {
                    setState(() {
                      quanAlert = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _imagePickerContainer(),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Variants",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9F9F9F)),
                ),
                const SizedBox(height: 10),
                _variantContainer(),
                const SizedBox(height: 20),
                _addVariantContainer(),
                const SizedBox(height: 80),
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
                    "Ajouter l'article",
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

  Widget _addVariantContainer() {
    return InkWell(
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFF0066FF).withOpacity(0.1),
          ),
          child: const Center(
            child: Text(
              'Ajouter un variant',
              style: TextStyle(
                color: Color(0xFF0066FF),
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          )),
    );
  }

  Widget _imagePickerContainer() {
    return InkWell(
      onTap: () => _selectImage(context),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF0066FF).withOpacity(0.1),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              color: Color(0xFF0066FF),
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Ajouter une photo',
              style: TextStyle(
                color: Color(0xFF0066FF),
                fontFamily: 'Inter',
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _variantContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white, // Use white as the background color
        borderRadius: BorderRadius.circular(5), // Apply border-radius of 5px
        boxShadow: const [
          BoxShadow(
            color:
                Color.fromRGBO(0, 0, 0, 0.15), // Apply the specified box-shadow
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInputField(
            label: "Nom de la couleur",
            hintText: "Entrez le nom de la couleur",
            errorText: "Vous devez entrer le nom de la couleur",
            value: quanAlert,
            onChanged: (value) {
              setState(() {
                quanAlert = value;
              });
            },
          ),
          const SizedBox(
            height: 18,
          ),
          _buildInputField(
            label: "Code de la couleur",
            hintText: "Entrez le code HEX de la couleur",
            errorText: "Vous devez entrer un code HEX valide",
            value: quanAlert,
            onChanged: (value) {
              setState(() {
                quanAlert = value;
              });
            },
          ),
          const SizedBox(
            height: 18,
          ),
          _buildInputField(
            label: "Taille",
            hintText: "Entrez la taille",
            errorText: "Vous devez entrer une taille",
            value: quanAlert,
            onChanged: (value) {
              setState(() {
                quanAlert = value;
              });
            },
          ),
          const SizedBox(
            height: 18,
          ),
          _buildInputField(
            label: "Quantité",
            hintText: "Entrez la Quantité",
            errorText: "Vous devez entrer la Quantité",
            value: quanAlert,
            onChanged: (value) {
              setState(() {
                quanAlert = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    String? label,
    String? hintText,
    String? errorText,
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
        // const SizedBox(height: 4), // Smaller gap here
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9F9F9F)),
            contentPadding:
                EdgeInsets.symmetric(vertical: 8), // Smaller padding here
            border: const UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 2), // Smaller gap here
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            errorText!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectField({
    required String label,
    required String hintText,
    required String? value,
    required String errorText,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9F9F9F)),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              hint: Text(hintText),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              items: [],
              // Add your DropdownMenuItem items here
            ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            errorText,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  void _selectImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Perform operations with the selected image.
    }
  }
}
