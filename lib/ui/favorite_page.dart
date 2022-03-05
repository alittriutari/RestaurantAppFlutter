import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/widget/restaurant_item_widget.dart';

import '../utils/helper.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Favorite Restaurant')),
        body: ChangeNotifierProvider(
            create: (context) => DbProvider(),
            child: Consumer<DbProvider>(builder: (context, value, child) {
              if (value.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.state == ResultState.hasData) {
                return ListView.builder(
                  itemCount: value.favorite.length,
                  itemBuilder: (context, index) {
                    return RestaurantItemWidget(restaurant: value.favorite[index]);
                  },
                );
              } else {
                return Center(child: Text(value.message));
              }
            })));
  }
}
