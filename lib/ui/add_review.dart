import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';
import 'package:restaurant_app/utils/helper.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:restaurant_app/widget/custom_textfield.dart';

// ignore: must_be_immutable
class AddReviewPage extends StatelessWidget {
  final RestaurantItem restaurantItem;
  AddReviewPage({Key? key, required this.restaurantItem}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Review'),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider(
          create: (context) => DetailRestaurantProvider(
              apiService: ApiService(), id: restaurantItem.id),
          child: Consumer<DetailRestaurantProvider>(
              builder: (context, review, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              ApiService.baseImageUrlSmall +
                                  restaurantItem.pictureId,
                              fit: BoxFit.fill,
                              width: 100,
                              height: 80,
                            ),
                          ),
                          mediumHorizontalSpacing(),
                          Text(
                            restaurantItem.name,
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                      superLargeSpacing(),
                      CustomTextfield(
                          controller: nameController,
                          hintText: 'Name',
                          title: 'Name',
                          fillColor: accentColor,
                          onSubmit: (text) {},
                          showTitle: true),
                      mediumSpacing(),
                      CustomTextfield(
                        controller: reviewController,
                        hintText: 'Review',
                        title: 'Review',
                        fillColor: accentColor,
                        onSubmit: (text) {},
                        showTitle: true,
                        maxLines: 3,
                      ),
                      superLargeSpacing(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            review
                                .addUserReview(restaurantItem.id,
                                    nameController.text, reviewController.text)
                                .whenComplete(() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  ListRestaurantPage.routeName,
                                  (Route<dynamic> route) => false);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
