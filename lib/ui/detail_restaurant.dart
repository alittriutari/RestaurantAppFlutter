import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';

import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/widget/custom_cache_image.dart';
import 'package:restaurant_app/widget/detail_information_widget.dart';
import 'package:restaurant_app/widget/menu_information_widget.dart';
import 'package:restaurant_app/widget/review_widget.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return DetailRestaurantProvider(
              apiService: ApiService(), id: restaurant.id);
        }),
        ChangeNotifierProvider(create: (context) {
          return DbProvider();
        })
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _sliverAppBar(expandHeight, innerBoxIsScrolled,
                  restaurant.pictureId, context),
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
          }, body: Consumer<DetailRestaurantProvider>(
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
                return TabBarView(
                  children: [
                    DetailInformationWidget(
                      restaurantItem: detail.detailResult.restaurant,
                      restaurant: restaurant,
                    ),
                    MenuInformationWidget(
                        restaurantItem: detail.detailResult.restaurant),
                    const ReviewWidget()
                  ],
                );
              } else if (detail.state == ResultState.noData) {
                return Center(child: Text(detail.message));
              } else if (detail.state == ResultState.error) {
                return Center(child: Text(detail.message));
              } else {
                return const Text('');
              }
            }
          })),
        ),
      ),
    );
  }

  Widget _sliverAppBar(double expandHeight, bool innerBoxIsScrolled,
      String urlImage, BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandHeight,
      floating: true,
      forceElevated: innerBoxIsScrolled,
      pinned: true,
      titleSpacing: 0,
      backgroundColor: primaryColor,
      actionsIconTheme: const IconThemeData(opacity: 0.0),
      leading: IconButton(
        icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back),
        onPressed: () {
          Navigation.back();
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: SizedBox(
          height: expandHeight,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Hero(
                tag: urlImage,
                child: CustomCacheImage(
                  imageUrl: ApiService.baseImageUrlLarge + urlImage,
                  boxFit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ],
          ),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
