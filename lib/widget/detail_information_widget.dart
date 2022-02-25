import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import '../data/model/restaurant_detail.dart';
import '../provider/db_provider.dart';
import '../utils/helper.dart';
import '../common/styles.dart';

class DetailInformationWidget extends StatelessWidget {
  final RestaurantItem restaurantItem;
  final Restaurant restaurant;
  const DetailInformationWidget(
      {Key? key, required this.restaurantItem, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:
            BoxDecoration(boxShadow: defaultBoxShadow(), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(restaurantItem.name,
                        style: Theme.of(context).textTheme.headline4)),
                Consumer<DbProvider>(
                  builder: (context, fav, child) {
                    return FutureBuilder<bool>(
                      future: fav.getFavoriteById(restaurantItem.id),
                      builder: (context, snapshot) {
                        var isFavorite = snapshot.data ?? false;
                        return isFavorite
                            ? IconButton(
                                onPressed: () {
                                  fav.deleteFavorite(restaurantItem.id);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ))
                            : IconButton(
                                onPressed: () {
                                  fav.addFavorite(restaurant);
                                },
                                icon: const Icon(Icons.favorite_border));
                      },
                    );
                  },
                )
              ],
            ),
            smallSpacing(),
            Row(
              children: [
                const Icon(Icons.location_on),
                Text(restaurantItem.city,
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            smallSpacing(),
            Text(restaurantItem.address,
                style: Theme.of(context).textTheme.bodyText1),
            smallSpacing(),
            RatingBarIndicator(
              rating: restaurantItem.rating,
              itemCount: 5,
              itemSize: 20,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: secondaryColor,
              ),
            ),
            largeSpacing(),
            Text(restaurantItem.description,
                style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
