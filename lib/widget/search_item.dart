import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/utils/styles.dart';

class SearchItem extends StatelessWidget {
  final Restaurant searchItem;
  const SearchItem({Key? key, required this.searchItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailRestaurantPage(
                  restaurant: searchItem,
                ),
              ));
        },
        child: Row(
          children: [
            Hero(
              tag: searchItem,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  ApiService.baseImageUrlSmall + searchItem.pictureId,
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
                  searchItem.name,
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
                    Text(searchItem.city)
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
