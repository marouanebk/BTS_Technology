import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/livreurs_page_view.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_livreur_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/new/new_user_page.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/pages_view.dart';
import 'package:bts_technologie/mainpage/presentation/screen/account%20manager/user_page_view.dart';
import 'package:flutter/material.dart';

class AccountManager extends StatefulWidget {
  const AccountManager({super.key});

  @override
  State<AccountManager> createState() => _AccountManagerState();
}

class _AccountManagerState extends State<AccountManager> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Gestionnaire des comptes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                pageViewController(0, "Utilisateurs"),
                pageViewController(1, "Pages"),
                pageViewController(2, "Livreurs"),
              ],
            ),
          ),
          // Container for the PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: const [
                UsersInfoPageVIew(),
                PagesInfoPageView(),
                LivreursInfoPageView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CustomPopupMenuButton(
        onItemSelected: (value) {
          if (value == 'Ajouter une page') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const NewUserPage(),
              ),
            );
          } else if (value == 'Ajouter un utilisateur') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const NewPageAccount(),
              ),
            );
          } else if (value == 'Ajouter un livreur') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const NewLivreurAccount(),
              ),
            );

          }

          setState(() {
            _isMenuOpen = false;
          });
        },
        isMenuOpen: _isMenuOpen,
      ),
    );
  }

  Widget pageViewController(int index, String text) {
    final isSelected = index == _currentPageIndex;
    final textStyle = TextStyle(
      color: isSelected
          ? const Color(0xFF111111)
          : const Color(0xFF9F9F9F), // Conditional color
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.0, // line-height normal
    );

    return InkWell(
      onTap: () {
        setState(() {
          _pageController.jumpToPage(index);
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: textStyle,
          ),
          if (isSelected)
            Center(
              child: Container(
                height: 3,
                width: 90,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(22),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomPopupMenuButton extends StatelessWidget {
  final bool isMenuOpen;

  final Function(String) onItemSelected;

  const CustomPopupMenuButton(
      {required this.isMenuOpen, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      child: PopupMenuButton<String>(
        offset: const Offset(-50, -150), // Move the button 50 pixels up
        color: Colors.black,
        onSelected: (value) {
          onItemSelected(value);
        },

        icon: Icon(
          isMenuOpen
              ? Icons.close
              : Icons.add, // Change the icon based on the menu state
          size: 35,
          color: Colors.white,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Ajouter une page',
            child: Text(
              "Ajouter une page",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ),
          const PopupMenuItem(
            value: 'Ajouter un utilisateur',
            child: Text(
              "Ajouter un utilisateur",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ),
          const PopupMenuItem(
            value: 'Ajouter un livreur',
            child: Text(
              "Ajouter un livreur",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
