import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/utils/styles.dart';

class ReviewItem extends StatelessWidget {
  final CustomerReview customerReview;
  const ReviewItem({Key? key, required this.customerReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: defaultBoxShadow()),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    customerReview.name,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    customerReview.date,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
              mediumSpacing(),
              Text(
                customerReview.review,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
