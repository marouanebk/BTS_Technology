import 'dart:developer';

import 'package:bts_technologie/orders/presentation/screen/commandes.dart';

import 'package:bts_technologie/notifications/presentation/screen/notifications.dart';
import 'package:bts_technologie/authentication/presentation/screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<Widget> _buildScreens(context) {
    return [
      const OrdersPage(
        role: "pageAdmin",
      ),
      const Notifications(),
      Builder(
        builder: (context) {
          return Container();
        }
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    void performLogout(BuildContext? context) async {
      // Your logout logic goes here
      if (context == null) {
        log("context null");
        // Handle the situation when the context is null.
        return;
      }
      // After logout, you can navigate to the login page using Navigator
      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt('is logged in', 0);
      await prefs.remove("id");
      await prefs.remove('type');
      await prefs.remove("token");
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const LoginPage();
          },
        ),
        (_) => false,
      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         LoginPage(), // Replace LoginPage with your login screen widget
      //   ),
      // );
    }

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
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/navbar/logout.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/images/navbar/logout.svg', // Replace with the actual path to your SVG image
          width: 20,
          height: 30,
        ),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.red,
        onPressed: performLogout, // Pass the context directly.
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
        navBarStyle:
            NavBarStyle.style5, // Choose the nav bar style with this property.
      );
    });
  }
}
