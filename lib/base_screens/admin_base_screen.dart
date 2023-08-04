import 'package:bts_technologie/orders/presentation/screen/commandes.dart';

import 'package:bts_technologie/notifications/presentation/screen/notifications.dart';
import 'package:bts_technologie/authentication/presentation/screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AdminPageBaseScreen extends StatefulWidget {
  const AdminPageBaseScreen({Key? key}) : super(key: key);
  @override
  State<AdminPageBaseScreen> createState() => _AdminPageBaseScreenState();
}

class _AdminPageBaseScreenState extends State<AdminPageBaseScreen> {
  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const OrdersPage(),
      const Notifications(),
      Container(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    void performLogout(BuildContext? context) {
      // Your logout logic goes here
      if (context == null) {
        // Handle the situation when the context is null.
        return;
      }
      // For example, clearing user data, navigating back to the login page, etc.
      // After logout, you can navigate to the login page using Navigator

      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
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
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
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
  }
}
