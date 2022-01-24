import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/detail_restaurant.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:restaurant_app/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Restaurant List'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/file/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final restaurantList = Restaurant.fromJson(jsonDecode(snapshot.data!));
            return ListView.builder(
              itemCount: restaurantList.restaurants.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, DetailRestaurant.routeName, arguments: restaurantList.restaurants);
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            restaurantList.restaurants[index].pictureId,
                            fit: BoxFit.fill,
                            width: 120,
                            height: 100,
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
                            RatingBarIndicator(
                              rating: restaurantList.restaurants[index].rating,
                              itemCount: 5,
                              itemSize: 15.0,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: secondaryColor,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(restaurantList.restaurants[index].city),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
