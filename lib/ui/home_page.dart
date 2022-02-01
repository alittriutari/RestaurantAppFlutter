import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/platform_widget.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/utils/styles.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Restaurant List'),
      ),
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
          FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/file/local_restaurant.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final jsonResult = jsonDecode(snapshot.data!);
                var restaurantList = restaurantFromJson(jsonEncode(jsonResult));

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurantList.restaurants.length,
                  itemBuilder: (context, index) {
                    return _restaurantItem(context, restaurantList, index);
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  Padding _restaurantItem(
      BuildContext context, Restaurant restaurantList, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailRestaurant(
                  restaurant: restaurantList.restaurants[index],
                ),
              ));
        },
        child: Row(
          children: [
            Hero(
              tag: restaurantList.restaurants[index].pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  restaurantList.restaurants[index].pictureId,
                  fit: BoxFit.fill,
                  width: 100,
                  height: 80,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantList.restaurants[index].name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: accentColor,
                      size: 20,
                    ),
                    Text(restaurantList.restaurants[index].city)
                  ],
                ),
                mediumSpacing(),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: secondaryColor,
                      size: 20,
                    ),
                    Text(restaurantList.restaurants[index].rating.toString())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
