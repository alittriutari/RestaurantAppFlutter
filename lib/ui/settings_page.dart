import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            title: Text(
              'Restaurant Notification',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            subtitle: Text(
              'Enable notifications',
              style: Theme.of(context).textTheme.caption,
            ),
            trailing: Switch.adaptive(value: true, onChanged: (onChanged) {}),
          ),
        ),
      ),
    );
  }
}
