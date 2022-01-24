import 'package:flutter/material.dart';
import 'package:restaurant_app/routes.dart' as router;

import 'package:restaurant_app/splash.dart';
import 'styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: primaryColor, onPrimary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
          colorScheme: Theme.of(context).colorScheme.copyWith(primary: primaryColor, secondary: secondaryColor, onPrimary: Colors.white)),
      home: const SplashPage(),
    );
  }
}
