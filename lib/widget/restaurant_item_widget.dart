import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/widget/custom_cache_image.dart';

class RestaurantItemWidget extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantItemWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => DetailRestaurantPage(
          //         restaurant: restaurant,
          //       ),
          //     ));
          Navigation.intentWithData(DetailRestaurantPage.routeName, restaurant);
        },
        child: Row(
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CustomCacheImage(
                  imageUrl: ApiService.baseImageUrlSmall + restaurant.pictureId,
                  boxFit: BoxFit.fill,
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
                  restaurant.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 20,
                    ),
                    Text(restaurant.city)
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
                    Text(restaurant.rating.toString())
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
