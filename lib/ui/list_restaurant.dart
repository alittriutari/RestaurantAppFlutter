import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/ui/search_page.dart';

import '../provider/restaurant_provider.dart';
import '../utils/platform_widget.dart';
import '../widget/restaurant_item_widget.dart';

class ListRestaurantPage extends StatelessWidget {
  static const routeName = '/home_page';
  const ListRestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: const Text('Restaurant List'), actions: [IconButton(onPressed: () => Navigator.pushNamed(context, SearchPage.routeName), icon: const Icon(Icons.search))]),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Restaurant List'),
        trailing: IconButton(onPressed: () => Navigator.pushNamed(context, SearchPage.routeName), icon: const Icon(Icons.search)),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text('Restaurant', style: Theme.of(context).textTheme.headline4),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Text('Recommendation restaurant for you!', style: Theme.of(context).textTheme.subtitle2),
        ),
        Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (state.state == ResultState.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height + AppBar().preferredSize.height,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var res = state.result.restaurants[index];
                      return RestaurantItemWidget(restaurant: res);
                    },
                  ),
                );
              } else if (state.state == ResultState.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.error) {
                return Center(child: Text(state.message));
              } else {
                return const Text('');
              }
            }
          },
        ),
      ],
    );
  }
}
