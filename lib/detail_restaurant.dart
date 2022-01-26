import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/helper.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:restaurant_app/styles.dart';

class DetailRestaurant extends StatelessWidget {
  static const String routeName = '/detail-restaurant';
  final RestaurantElement restaurant;
  const DetailRestaurant({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double expandHeight = MediaQuery.of(context).size.height * 0.33;
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: expandHeight,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              pinned: true,
              titleSpacing: 0,
              backgroundColor: innerBoxIsScrolled ? primaryColor : primaryColor,
              actionsIconTheme: const IconThemeData(opacity: 0.0),
              flexibleSpace: FlexibleSpaceBar(
                background: SizedBox(
                  height: expandHeight,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Image.network(
                        restaurant.pictureId,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(restaurant.name, style: Theme.of(context).textTheme.headline3),
                    smallSpacing(),
                    Text(restaurant.city, style: Theme.of(context).textTheme.bodyText1),
                    RatingBarIndicator(
                      rating: restaurant.rating,
                      itemCount: 5,
                      itemSize: 20,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: secondaryColor,
                      ),
                    ),
                    largeSpacing(),
                    Text(restaurant.description, style: Theme.of(context).textTheme.bodyText2),
                    largeSpacing(),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        width: double.infinity,
                        color: accentColor,
                        child: Text('Menu', style: Theme.of(context).textTheme.subtitle1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Foods', style: Theme.of(context).textTheme.subtitle1),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: restaurant.menus.foods.length,
                            itemBuilder: (context, index) {
                              return Text(
                                restaurant.menus.foods[index].name,
                                style: Theme.of(context).textTheme.subtitle1,
                              );
                            },
                          ),
                          largeSpacing(),
                          const Divider(height: 3, color: secondaryColor),
                          largeSpacing(),
                          Text('Drinks', style: Theme.of(context).textTheme.subtitle1),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: restaurant.menus.drinks.length,
                            itemBuilder: (context, index) {
                              return Text(
                                restaurant.menus.drinks[index].name,
                                style: Theme.of(context).textTheme.subtitle1,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // totalRatting(food_lbl__96_rating),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
