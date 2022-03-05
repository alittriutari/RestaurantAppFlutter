import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/custom_textfield.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchCont = TextEditingController();
    return CustomTextfield(
      controller: searchCont,
      hintText: 'Search',
      title: '',
      fillColor: accentColor,
      onSubmit: (text) {
        Provider.of<SearchProvider>(context, listen: false).searchRestaurant(searchCont.text);
      },
      showTitle: false,
    );
  }
}
