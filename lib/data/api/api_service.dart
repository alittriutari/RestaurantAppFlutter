import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseImageUrlSmall = 'https://restaurant-api.dicoding.dev/images/small/';
  // https://restaurant-api.dicoding.dev/images/small/{pictureId}

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurant list');
    }
  }
}
