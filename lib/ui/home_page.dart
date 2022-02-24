import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';
import 'package:restaurant_app/ui/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [const ListRestaurantPage(), const FavoritePage(), const SettingsPage()];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Platform.isIOS ? CupertinoIcons.heart_circle_fill : Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings), label: 'Settings')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }
}
