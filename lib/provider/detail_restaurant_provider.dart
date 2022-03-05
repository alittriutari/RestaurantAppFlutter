import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/add_review.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../utils/helper.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({
    required this.apiService,
    required this.id,
  }) {
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurant _detailRestaurantResult;
  late ResultState _state;
  late AddReview _reviewResult;
  String _message = '';

  String get message => _message;
  DetailRestaurant get detailResult => _detailRestaurantResult;
  AddReview get reviewResult => _reviewResult;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _detailRestaurantResult = detailRestaurant;
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Check your internet connection';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Error $e';
      }
    }
  }

  Future<dynamic> addUserReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final userReview = await apiService.addReview(id, name, review);

      return _reviewResult = userReview;
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Check your internet connection';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Error $e';
      }
    }
  }
}
