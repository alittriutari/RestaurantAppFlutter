import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/utils/styles.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Abdul',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    '12 agustus',
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
              mediumSpacing(),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ',
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
