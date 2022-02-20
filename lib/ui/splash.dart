import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, ListRestaurantPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.5 / 1,
          child: Image.asset(
            'assets/img/logo.png',
          ),
        ),
      ),
    );
  }
}
