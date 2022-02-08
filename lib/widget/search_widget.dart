import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);

  TextEditingController searchCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        Provider.of<SearchProvider>(context, listen: false).searchRestaurant(searchCont.text);
      },
    );
  }
}
