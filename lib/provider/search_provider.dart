import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  SearchProvider({required this.apiService});

  late SearchResult _searchResult;
  ResultState _state = ResultState.noData;

  String _message = '';

  String get message => _message;
  SearchResult get result => _searchResult;
  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String searchText) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(searchText);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = restaurant;
      }
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
