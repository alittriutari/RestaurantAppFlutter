import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/platform_widget.dart';
import 'package:restaurant_app/widget/custom_dialog.dart';

import '../provider/preferences_provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: _buildWidget(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: _buildWidget(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Material(
            child: ListTile(
              title: Text(
                'Restaurant Notification',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              subtitle: Text(
                'Enable notifications',
                style: Theme.of(context).textTheme.caption,
              ),
              trailing: Consumer<PreferencesProvider>(builder: (context, daily, _) {
                return Consumer<SchedulingProvider>(builder: (context, scheduled, child) {
                  return Switch.adaptive(
                    value: daily.isDailyRestaurantActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledRestaurant(value);
                        daily.enableDailyRestaurant(value);
                      }
                    },
                    activeColor: secondaryColor,
                    activeTrackColor: secondaryColor.withOpacity(0.5),
                  );
                });
              }),
            ),
          ),
        ),
      ),
    );
  }
}
