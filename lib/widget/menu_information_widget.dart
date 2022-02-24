import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../utils/helper.dart';
import '../utils/styles.dart';

class MenuInformationWidget extends StatelessWidget {
  final RestaurantItem restaurantItem;
  const MenuInformationWidget({Key? key, required this.restaurantItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Menu', style: Theme.of(context).textTheme.headline6),
            superLargeSpacing(),
            Text('Food', style: Theme.of(context).textTheme.subtitle2),
            largeSpacing(),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                color: accentColor,
              ),
              itemCount: restaurantItem.menus.foods.length,
              itemBuilder: (context, index) {
                return Text(restaurantItem.menus.foods[index].name);
              },
            ),
            superLargeSpacing(),
            Text('Drink', style: Theme.of(context).textTheme.subtitle2),
            largeSpacing(),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                color: accentColor,
              ),
              itemCount: restaurantItem.menus.drinks.length,
              itemBuilder: (context, index) {
                return Text(restaurantItem.menus.drinks[index].name);
              },
            )
          ],
        ),
      ),
    );
  }
}
