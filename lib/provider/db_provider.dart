import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/utils/database_helper.dart';

import 'detail_restaurant_provider.dart';

class DbProvider extends ChangeNotifier {
  List<Favorite> _favorite = [];
  late DatabaseHelper _dbHelper;
  bool isFavorited = false;

  List<Favorite> get favorite => _favorite;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorite();
  }

  void _getAllFavorite() async {
    _favorite = await _dbHelper.getFavorite();
    notifyListeners();
  }

  void addFavorite(Favorite favorite) async {
    await _dbHelper.addFavorite(favorite);
    _getAllFavorite();
  }

  Future<Favorite> getFavoriteById(String id) async {
    return await _dbHelper.getFavoriteByRestaurantId(id);
  }

  void deleteFavorite(String id) async {
    await _dbHelper.deleteFavorite(id);
    _getAllFavorite();
  }

  Future<bool> isFav(String id) async {
    final favoriteData = await _dbHelper.getFavoriteByRestaurantId(id);
    if (favoriteData.id == id) {
      print('Its favourite and removing it');
      notifyListeners();
      return isFavorited = false;
      // notifyListeners();
    } else {
      print('Nothing found so inserting you dodo');
      notifyListeners();
      return isFavorited = true;
      // notifyListeners();
    }
  }
}
