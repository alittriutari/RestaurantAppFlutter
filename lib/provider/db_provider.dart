import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/data/db/database_helper.dart';

class DbProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;

  late ResultState _state;
  ResultState get state => _state;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  String _message = '';
  String get message => _message;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorite();
  }

  void _getAllFavorite() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      _favorite = await _dbHelper.getFavorite();
      if (_favorite.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
        _message = 'You don\'t have favorite restaurants';
      }
      notifyListeners();
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        _state = ResultState.error;
        notifyListeners();
        _message = 'Check your internet connection';
      } else {
        _state = ResultState.error;
        notifyListeners();
        _message = 'Error $e';
      }
    }
  }

  void addFavorite(Restaurant restaurant) async {
    await _dbHelper.addFavorite(restaurant);
    _getAllFavorite();
  }

  Future<bool> getFavoriteById(String id) async {
    final favoritedRestaurant = await _dbHelper.getFavoriteByRestaurantId(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void deleteFavorite(String id) async {
    await _dbHelper.deleteFavorite(id);
    _getAllFavorite();
  }
}
