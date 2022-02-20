import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/ui/add_review.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/widget/review_item.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail-restaurant';
  final Restaurant restaurant;
  const DetailRestaurantPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    double expandHeight = MediaQuery.of(context).size.height * 0.33;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return DetailRestaurantProvider(apiService: ApiService(), id: widget.restaurant.id);
        }),
        ChangeNotifierProvider(create: (context) {
          return DbProvider();
        })
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, detail, child) {
            if (detail.state == ResultState.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (detail.state == ResultState.hasData) {
                return DefaultTabController(
                  length: 3,
                  child: NestedScrollView(
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          _sliverAppBar(expandHeight, innerBoxIsScrolled, detail),
                          SliverPersistentHeader(
                            delegate: _SliverAppBarDelegate(
                              const TabBar(
                                labelColor: primaryColor,
                                indicatorColor: primaryColor,
                                unselectedLabelColor: darkGrey,
                                tabs: [
                                  Tab(text: 'Description'),
                                  Tab(text: 'Menu'),
                                  Tab(text: 'Review'),
                                ],
                              ),
                            ),
                            pinned: true,
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: [
                          _detailInfo(context, detail.detailResult.restaurant),
                          _menuInfo(context, detail.detailResult.restaurant),
                          _reviewTab(context),
                        ],
                      )),
                );
              } else if (detail.state == ResultState.noData) {
                return Center(child: Text(detail.message));
              } else if (detail.state == ResultState.error) {
                return Center(child: Text(detail.message));
              } else {
                return const Text('');
              }
            }
          },
        ),
      ),
    );
  }

  Widget _sliverAppBar(double expandHeight, bool innerBoxIsScrolled, DetailRestaurantProvider detail) {
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
                tag: detail.detailResult.restaurant.pictureId,
                child: Image.network(
                  ApiService.baseImageUrlLarge + detail.detailResult.restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reviewTab(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(builder: (context, review, child) {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewPage(restaurantItem: review.detailResult.restaurant)))
                          .then((_) => setState(() {}));
                    },
                    child: const Text('Add Review'),
                  ),
                ],
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: review.detailResult.restaurant.customerReviews.length,
                  itemBuilder: (context, index) {
                    return ReviewItem(customerReview: review.detailResult.restaurant.customerReviews[index]);
                  }),
            ],
          ),
        ),
      );
    });
  }

  _detailInfo(BuildContext context, RestaurantItem restaurantItem) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(restaurantItem.name, style: Theme.of(context).textTheme.headline4)),
                Consumer<DbProvider>(
                  builder: (context, fav, child) {
                    // final asdd = Favorite(favorite: 1, restaurantId: restaurantItem.id);
                    // fav.addFavorite(asdd);
                    return IconButton(
                        onPressed: () {
                          // final asdd = Favorite(favorite: 1, restaurantId: restaurantItem.id);
                          // fav.addFavorite(asdd);
                          print(fav.getFavoriteById(restaurantItem.id));
                        },
                        icon: Icon(Icons.favorite));
                  },
                )
              ],
            ),
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
          ],
        ),
      ),
    );
  }

  Widget _menuInfo(BuildContext context, RestaurantItem restaurantItem) {
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      color: Colors.white,
      child: Container(child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
