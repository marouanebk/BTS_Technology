import 'package:bts_technologie/orders/presentation/screen/commandes.dart';
import 'package:bts_technologie/finances/presentation/screen/finances.dart';
import 'package:bts_technologie/notifications/presentation/screen/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const OrdersPage(),
      const Notifications(),
      const FinancesPage(),
      Container()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
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
      screens: _buildScreens(),
      items: _navBarsItems(),
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
