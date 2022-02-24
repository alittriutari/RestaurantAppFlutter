import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/custom_textfield.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);

  TextEditingController searchCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      controller: searchCont,
      hintText: 'Search',
      title: '',
      fillColor: accentColor,
      onSubmit: (text) {
        Provider.of<SearchProvider>(context, listen: false)
            .searchRestaurant(searchCont.text);
      },
      showTitle: false,
    );
  }
}
