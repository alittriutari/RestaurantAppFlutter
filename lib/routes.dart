import 'package:flutter/material.dart';
import 'package:restaurant_app/home_page.dart';
import 'package:restaurant_app/splash.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => HomePage());
    default:
      return MaterialPageRoute(builder: (context) => SplashPage());
  }
}
