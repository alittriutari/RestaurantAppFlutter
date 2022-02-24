import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/utils/database_helper.dart';

class DbProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;

  late ResultState _state;
  ResultState get state => _state;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorite();
  }

  void _getAllFavorite() async {
    _favorite = await _dbHelper.getFavorite();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
    }
    notifyListeners();
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
