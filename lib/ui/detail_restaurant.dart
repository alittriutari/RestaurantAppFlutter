import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/styles.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = '/detail-restaurant';
  final RestaurantElement restaurant;
  const DetailRestaurantPage({
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
            detailSliverAppbar(expandHeight, innerBoxIsScrolled),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _detailInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar detailSliverAppbar(double expandHeight, bool innerBoxIsScrolled) {
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
                tag: restaurant.pictureId,
                child: Image.network(
                  ApiService.baseImageUrlLarge + restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _detailInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(restaurant.name, style: Theme.of(context).textTheme.headline3),
          smallSpacing(),
          Row(
            children: [
              const Icon(Icons.location_on),
              Text(restaurant.city, style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
          smallSpacing(),
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
        ],
      ),
    );
  }
}
