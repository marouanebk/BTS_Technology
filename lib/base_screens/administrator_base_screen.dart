import 'package:bts_technologie/logistiques/presentation/screen/logistiques.dart';
import 'package:bts_technologie/orders/presentation/screen/commandes.dart';
import 'package:bts_technologie/finances/presentation/screen/finances.dart';
import 'package:bts_technologie/mainpage/presentation/screen/main_page.dart';
import 'package:bts_technologie/notifications/presentation/screen/notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PageAdministratorBaseScreen extends StatefulWidget {
  final int initialIndex; // Add the parameter

  const PageAdministratorBaseScreen({this.initialIndex = 0, Key? key})
      : super(key: key);
  @override
  State<PageAdministratorBaseScreen> createState() =>
      _PageAdministratorBaseScreenState();
}

class _PageAdministratorBaseScreenState
    extends State<PageAdministratorBaseScreen> {
  late PersistentTabController _controller;

  // final _controller = PersistentTabController(initialIndex: widget.initialIndex);

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    });
  }

  List<Widget> _buildScreens(context) {
    return [
      const MainPage(),
      const OrdersPage(
        role: "admin",
      ),
      const Notifications(),
      const Logistiques(
        role: "admin",
      ),
      const FinancesPage(
        role: "admin",
      )
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/home_activated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/images/navbar/home_desactivated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        title: 'home',
        activeColorPrimary: Colors.black,
        activeColorSecondary:
            Colors.black, // Set the background color when activated
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
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
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/notifications_activated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        inactiveIcon: Image.asset(
          'assets/images/navbar/notifications_desactivated.png', // Replace with the actual path to your SVG image
          width: 25,
          height: 35,
          color: Colors.black,
        ),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/logis_activated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/images/navbar/logistics_desactivated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/finances_activated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/images/navbar/finances_desactivated.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(context),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
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
}
