import 'package:flutter/material.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: FutureBuilder<String>(
      //   future: DefaultAssetBundle.of(context).loadString('assets/file/local_restaurant.json'),
      // ),
    );
  }
}
