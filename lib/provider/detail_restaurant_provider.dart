import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider(this.id, {required this.apiService}) {
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurantResult _detailRestaurantResult;
  late ResultState _state;

  String _message = '';

  String get message => _message;
  DetailRestaurantResult get detailResult => _detailRestaurantResult;
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
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error $e';
    }
  }
}
