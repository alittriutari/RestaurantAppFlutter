import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/img/logo.png'),
          Text(
            'Restaurant App',
            style: Theme.of(context).textTheme.headline1,
          )
        ],
      ),
    );
  }
}
