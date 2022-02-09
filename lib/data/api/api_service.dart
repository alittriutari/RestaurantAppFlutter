import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/add_review.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

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

  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load detail restaurant');
    }
  }

  Future<SearchResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurant list');
    }
  }

  Future<AddReview> addReview(String id, String name, String review) async {
    Map data = {"id": id, "name": name, "review": review};
    final response = await http.post(
      Uri.parse(_baseUrl + 'review'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: data,
    );
    if (response.statusCode == 200) {
      return AddReview.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurant list');
    }
  }
}
