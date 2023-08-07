import 'package:bts_technologie/mainpage/presentation/components/search_container.dart';
import 'package:flutter/material.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  String searchQuery = ''; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Align the title to the center

        title: const Text(
          "List des clients ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),

        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              searchContainer("Chercher un client ", (query) {
                setState(() {
                  searchQuery = query;
                });
              }),
              const SizedBox(
                height: 30,
              ),
              clientList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clientList() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => const SizedBox(
        height: 14,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return clientContainer();
      },
    );
  }

  Widget clientContainer() {
    return Container(
      height: 62,
      width: double.infinity,
      padding: const EdgeInsets.only(right: 24, left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes the shadow position
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Mohamed smth ",
            style: TextStyle(
              color: Color(
                  0xFF111111), // Assuming you have defined the black color as #111
              height: 1.0, // Equivalent to "line-height: normal;"
              fontFamily:
                  'Inter', // Assuming you have loaded the Inter font family
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "123",
            style: TextStyle(
              color: Color(
                  0xFF111111), // Assuming you have defined the black color as #111
              height: 1.0, // Equivalent to "line-height: normal;"
              fontFamily:
                  'Inter', // Assuming you have loaded the Inter font family
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
