import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/widget/review_item.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({Key? key, required this.restaurantItem}) : super(key: key);
  final RestaurantItem restaurantItem;
  static const routeName = '/review_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: const Text('User Reviews'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${restaurantItem.customerReviews.length} Reviews ',
                style: Theme.of(context).textTheme.headline5,
              ),
              largeSpacing(),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurantItem.customerReviews.length,
                  itemBuilder: (context, index) {
                    return ReviewItem(customerReview: restaurantItem.customerReviews[index]);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
