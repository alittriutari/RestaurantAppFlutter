import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant.dart';

class DetailRestaurant extends StatelessWidget {
  static const String routeName = '/detail-restaurant';
  final Restaurant restaurant;
  const DetailRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('hai'),
    );
  }
}
