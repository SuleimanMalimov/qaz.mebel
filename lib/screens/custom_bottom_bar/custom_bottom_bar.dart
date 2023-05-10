// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qaz_mebel/screens/account_screen/account_screens.dart';
import 'package:qaz_mebel/screens/cart_screen/cart_screen.dart';
import 'package:qaz_mebel/screens/favourite_screen/favourite_screen.dart';
import 'package:qaz_mebel/screens/home/home.dart';
import 'package:qaz_mebel/screens/order_screen/order_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const Home(),
        const CartScreen(),
        const FavouriteScreen(),
        const AccountScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined),
          title: "Главная",
          activeColorPrimary: Color(0xffd28629),
          inactiveColorPrimary: Color(0xfff89c2e),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          inactiveIcon: const Icon(Icons.shopping_cart_outlined),
          title: "Корзина",
          activeColorPrimary: Color(0xffd28629),
          inactiveColorPrimary: Color(0xfff89c2e),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite),
          inactiveIcon: const Icon(Icons.favorite_border),
          title: "Избранные",
          activeColorPrimary: Color(0xffd28629),
          inactiveColorPrimary: Color(0xfff89c2e),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Профиль",
          activeColorPrimary: Color(0xffd28629),
          inactiveColorPrimary: Color(0xfff89c2e),
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: Color(0xFFFFFFFF),
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
