import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/ui/add_review.dart';
import 'package:restaurant_app/ui/review_list.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/widget/review_item.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail-restaurant';
  final Restaurant restaurant;
  const DetailRestaurantPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double expandHeight = MediaQuery.of(context).size.height * 0.33;
    return ChangeNotifierProvider(
      create: (context) {
        return DetailRestaurantProvider(apiService: ApiService(), id: restaurant.id);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, detail, child) {
            if (detail.state == ResultState.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (detail.state == ResultState.hasData) {
                return NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        detailSliverAppbar(expandHeight, innerBoxIsScrolled, detail.detailResult.restaurant),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _detailInfo(context, detail.detailResult.restaurant),
                        ],
                      ),
                    ));
              } else if (detail.state == ResultState.noData) {
                return Center(child: Text(detail.detailResult.message));
              } else if (detail.state == ResultState.error) {
                return Center(child: Text(detail.detailResult.message));
              } else {
                return const Text('');
              }
            }
          },
        ),
        bottomNavigationBar: Consumer<DetailRestaurantProvider>(
          builder: (context, detail, child) {
            return ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewPage(restaurantItem: detail.detailResult.restaurant)));
              },
              child: const Text('Add Review'),
            );
          },
        ),
      ),
    );
  }

  detailSliverAppbar(double expandHeight, bool innerBoxIsScrolled, RestaurantItem restaurantItem) {
    return SliverAppBar(
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
              Hero(
                tag: restaurantItem.pictureId,
                child: Image.network(
                  ApiService.baseImageUrlLarge + restaurantItem.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _detailInfo(BuildContext context, RestaurantItem restaurantItem) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(restaurantItem.name, style: Theme.of(context).textTheme.headline4),
          smallSpacing(),
          Row(
            children: [
              const Icon(Icons.location_on),
              Text(restaurantItem.city, style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
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
          Text(restaurantItem.description, style: Theme.of(context).textTheme.bodyText2),
          largeSpacing(),
          Text(
            'Review',
            style: Theme.of(context).textTheme.headline6,
          ),
          smallSpacing(),
          Text(
            '(${restaurantItem.customerReviews.length} review)',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          mediumSpacing(),
          ReviewItem(
            customerReview: restaurantItem.customerReviews.first,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewListPage(
                          restaurantItem: restaurantItem,
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'More',
                    style: Theme.of(context).textTheme.overline,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
