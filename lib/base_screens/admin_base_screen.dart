import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bts_technologie/orders/presentation/screen/commandes.dart';
import 'package:bts_technologie/notifications/presentation/screen/notifications.dart';
import 'package:bts_technologie/authentication/presentation/screen/login_page.dart';

class AdminPageBaseScreen extends StatefulWidget {
  final int initialIndex; // Add the parameter

  const AdminPageBaseScreen({this.initialIndex = 0, Key? key})
      : super(key: key);
  @override
  State<AdminPageBaseScreen> createState() => _AdminPageBaseScreenState();
}

class _AdminPageBaseScreenState extends State<AdminPageBaseScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/commandes_activated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/images/navbar/commandes_desactivated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        title: 'Commandes',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/notifications_activated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/images/navbar/notifications_desactivated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        title: 'Notifications',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/logout.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        title: 'Logout',
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.red,

        onPressed: (context) => performLogout(), // Pass context here
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      items: _navBarsItems(context),
      screens: [
        const OrdersPage(
          role: "pageAdmin",
        ),
        const Notifications(),
        Container(),
      ],
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style5,
    );
  }

  void performLogout() async {
    final prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Déconnexion"),
          content: Text("Êtes vous sûr de vouloir quitter déconnecter ? "),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close the dialog
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                await prefs.setInt('is logged in', 0);
                await prefs.remove("id");
                await prefs.remove('type');
                await prefs.remove("token");
                // Navigate to the login page and remove all previous routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LoginPage();
                    },
                  ),
                  (_) => false,
                );
              },
              child: Text("Déconnecter"),
            ),
          ],
        );
      },
    );

  }
}
