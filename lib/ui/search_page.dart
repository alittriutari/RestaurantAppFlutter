import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/styles.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  static const routeName = '/search';
  SearchPage({Key? key}) : super(key: key);

  TextEditingController searchCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SearchProvider>(builder: (context, search, _) {
          return Column(
            children: [
              TextFormField(
                controller: searchCont,
                decoration: InputDecoration(
                    filled: true,
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: accentColor),
                onFieldSubmitted: (String searchText) {
                  search.searchText = searchCont.text;
                  print('search ' + search.searchText);
                },
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: search.result.restaurants.length,
                  itemBuilder: (context, index) {
                    return Text(search.result.restaurants[index].name);
                  })
            ],
          );
        }),
      ),
    );
  }
}
