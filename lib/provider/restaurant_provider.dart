import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/add_review.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaurantResult;
  late AddReview _reviewResult;
  late ResultState _state;

  String _message = '';

  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  AddReview get reviewResult => _reviewResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error $e';
    }
  }

  Future<dynamic> addUserReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final userReview = await apiService.addReview(id, name, review);

      return _reviewResult = userReview;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error $e';
    }
  }
}
