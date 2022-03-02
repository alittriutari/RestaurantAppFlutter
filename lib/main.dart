import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/ui/add_review.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/ui/splash.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/styles.dart';
import 'data/model/restaurant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (context) => SearchProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (context) => SchedulingProvider()),
        ChangeNotifierProvider(
            create: (context) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
            textTheme: myTheme,
            appBarTheme: const AppBarTheme(elevation: 0),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    primary: primaryColor,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)))),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
                onPrimary: Colors.white)),
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          ListRestaurantPage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          FavoritePage.routeName: (context) => const FavoritePage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          AddReviewPage.routeName: (context) => AddReviewPage(
              restaurantItem:
                  ModalRoute.of(context)?.settings.arguments as RestaurantItem),
          DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant)
        },
      ),
    );
  }
}
