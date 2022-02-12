import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/utils/enum.dart';
import 'package:restaurant_app/utils/platform_widget.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Restaurant List'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, SearchPage.routeName),
                icon: const Icon(Icons.search))
          ]),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant List'),
      ),
      child: _buildList(context),
    );
  }

  SingleChildScrollView _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text('Restaurant',
                style: Theme.of(context).textTheme.headline4),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Text('Recommendation restaurant for you!',
                style: Theme.of(context).textTheme.subtitle2),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var res = state.result.restaurants[index];
                      return RestaurantItem(restaurant: res);
                    },
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
      ),
    );
  }
}
