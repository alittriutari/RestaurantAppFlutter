import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/utils/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreferences();
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
  }
}
