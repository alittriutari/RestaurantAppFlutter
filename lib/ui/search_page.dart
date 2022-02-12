import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/enum.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/search_widget.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  static const routeName = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchWidget(),
              largeSpacing(),
              Consumer<SearchProvider>(builder: (context, search, _) {
                if (search.state == ResultState.loading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (search.state == ResultState.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: search.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var res = search.result.restaurants[index];
                        return RestaurantItem(restaurant: res);
                      },
                    );
                  } else if (search.state == ResultState.noData) {
                    return Center(child: Text(search.message));
                  } else if (search.state == ResultState.error) {
                    return Center(child: Text(search.message));
                  } else {
                    return const Text('');
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
