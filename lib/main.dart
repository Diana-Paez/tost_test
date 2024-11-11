import 'package:flutter/material.dart';

import 'package:stacked_services/stacked_services.dart';

import 'package:flutter_test_tots/app/app.locator.dart';
import 'package:flutter_test_tots/app/app.router.dart';
import 'package:flutter_test_tots/app/core/theme/app_theme.dart';

void main() {
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'TOTS APP',
      navigatorKey: StackedService.navigatorKey,
      initialRoute: AppRouter.loginRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
