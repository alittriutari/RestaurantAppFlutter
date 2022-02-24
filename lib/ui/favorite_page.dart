import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/widget/restaurant_item_widget.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider(
            create: (context) => DbProvider(),
            child: Consumer<DbProvider>(builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.favorite.length,
                itemBuilder: (context, index) {
                  return RestaurantItemWidget(
                      restaurant: value.favorite[index]);
                },
              );
            })));
  }
}
