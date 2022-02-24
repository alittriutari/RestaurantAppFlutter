import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/review_item.dart';

import '../provider/detail_restaurant_provider.dart';
import '../ui/add_review.dart';
import '../utils/helper.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
        builder: (context, review, child) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Review',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      smallSpacing(),
                      Text(
                        '(${review.detailResult.restaurant.customerReviews.length} review)',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddReviewPage(
                                  restaurantItem:
                                      review.detailResult.restaurant)));
                    },
                    child: const Text('Add Review'),
                  ),
                ],
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      review.detailResult.restaurant.customerReviews.length,
                  itemBuilder: (context, index) {
                    return ReviewItem(
                        customerReview: review
                            .detailResult.restaurant.customerReviews[index]);
                  }),
            ],
          ),
        ),
      );
    });
  }
}
