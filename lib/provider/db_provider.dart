import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/utils/database_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Favorite> _favorite = [];
  late DatabaseHelper _dbHelper;

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

  // void updateFavorite(Favorite favorite) async {
  //   await _dbHelper.updateFavorite(favorite);
  //   _getAllFavorite();
  // }

  void deleteFavorite(int id) async {
    await _dbHelper.deleteFavorite(id);
    _getAllFavorite();
  }
}
