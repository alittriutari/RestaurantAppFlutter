import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseImageUrlSmall = 'https://restaurant-api.dicoding.dev/images/small/';
  static const String baseImageUrlLarge = 'https://restaurant-api.dicoding.dev/images/large/';

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurant list');
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + '/detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurant list');
    }
  }

  Future<RestaurantResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurant list');
    }
  }
}
