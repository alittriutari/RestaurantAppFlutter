import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/utils/platform_widget.dart';
import 'package:restaurant_app/widget/restaurant_item_widget.dart';

import '../utils/helper.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorite Restaurant'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorite Restaurant'),
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider(
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
        }));
  }
}
