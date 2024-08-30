import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

import 'pages.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  /// The path for the more page.
  static const String path = '/more';

  /// The name for the more page.
  static const String name = 'More';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.goNamed(ProfilePage.name),
              child: const Text('Profile'),
            ),
            const SizedBox(height: kMaterialMediumAndUpMargin),
            ElevatedButton(
              onPressed: () => context.goNamed(SettingsPage.name),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
